extends Node

@export var PlayerSpeed = 400

func _ready() -> void:
	if multiplayer.is_server:
		print("Server properties created")
	else:
		print("Remove server properties synced")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		PlayerSpeed += 25
	if Input.is_action_just_pressed("ui_down"):
		PlayerSpeed -= 25
