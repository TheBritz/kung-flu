extends CharacterBody2D

var serverProperties: Node

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	serverProperties = get_node("../ServerProperties")

func _physics_process(delta):
	if is_multiplayer_authority():
		var playerSpeed = serverProperties.PlayerSpeed if serverProperties.PlayerSpeed else 400
		var maxVelocity = Vector2(playerSpeed, playerSpeed) 
		var minVelocity = Vector2(-playerSpeed, -playerSpeed) 
		var inputAcc = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 25 #playerSpeed
		var xAcc = inputAcc.x
		if inputAcc.x == 0:
			xAcc = -sign(velocity.x) * 7
		var yAcc = inputAcc.y
		if inputAcc.y == 0:
			yAcc = -sign(velocity.y) * 7
		velocity.x += xAcc
		velocity.y += yAcc
		velocity = velocity.clamp(minVelocity, maxVelocity)
	move_and_slide() 
