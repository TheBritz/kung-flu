extends Node

@export var PlayerSpeed = 400

func _ready() -> void:
	if multiplayer.is_server:
		print("Server properties created")
	else:
		print("Remove server properties synced")
