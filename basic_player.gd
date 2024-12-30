extends CharacterBody2D

var serverProperties: Node

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	serverProperties = get_node("../ServerProperties")

func _physics_process(delta):
	if is_multiplayer_authority():
		var playerSpeed = serverProperties.PlayerSpeed if serverProperties.PlayerSpeed else 400
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * playerSpeed
	move_and_slide() 
