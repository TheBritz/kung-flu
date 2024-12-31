extends CharacterBody2D

var serverProperties: Node

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	serverProperties = get_node("../ServerProperties")

func _physics_process(delta):
	if is_multiplayer_authority():
		# Gather base acceleration input, multiplied by PlayerBaseAcceleration
		var inputAcc = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * serverProperties.PlayerAccelBase #playerSpeed
		
		# Break input into x and y
		var xAcc = inputAcc.x
		var yAcc = inputAcc.y
		
		# Handle decceleration
		if inputAcc.x == 0:
			if inputAcc.y == 0:
				# Drift decceleration: should be a slower decceleration than active decceleration
				xAcc = -velocity.x * serverProperties.PlayerDeccelDrift
				yAcc = -velocity.y * serverProperties.PlayerDeccelDrift
			else:
				# Active decceleration: this should be a more rapid decceleration because we want
				#                       the movement to feel responsive and "snap" to a direction
				#                       quicker than when drifting. 
				xAcc = -velocity.x * serverProperties.PlayerDeccelActive
		elif inputAcc.y == 0:
			# Active decceleration
			yAcc = -velocity.y * serverProperties.PlayerDeccelActive
		velocity.x += xAcc
		velocity.y += yAcc
		
		# Clamp player speed to the designated maximum
		var playerSpeed = serverProperties.PlayerSpeed if serverProperties.PlayerSpeed else 400
		var maxVelocity = Vector2(playerSpeed, playerSpeed) 
		var minVelocity = Vector2(-playerSpeed, -playerSpeed) 
		velocity = velocity.clamp(minVelocity, maxVelocity)
	move_and_slide() 
