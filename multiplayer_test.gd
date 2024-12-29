extends Node2D

const PORT = 32420

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene

func _ready() -> void:
	var args = Array(OS.get_cmdline_args())
	if args.has("-s"):
		peer.create_server(PORT)
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(_add_player)
		var serverProps = preload("res://server_properties.tscn").instantiate()
		serverProps.name = "ServerProperties"
		add_child(serverProps)
	else:
		peer.create_client("localhost", PORT)
		multiplayer.multiplayer_peer = peer
	
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
