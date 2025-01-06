extends Node2D

var port = 32420
var serverHost = "172.2.0.218"

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene

func _ready() -> void:
	var arguments = {}
	for argument in OS.get_cmdline_args():
		if argument.contains("="):
			var key_value = argument.split("=")
			arguments[key_value[0].trim_prefix("--")] = key_value[1]
	if arguments.has("host"):
		serverHost = arguments.host
	if arguments.has("port"):
		port = arguments.port
		
	var args = Array(OS.get_cmdline_args())
	if args.has("-s"):
		Global.isServer = true
		peer.create_server(port)
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(_add_player)
		var serverProps = preload("res://server_properties.tscn").instantiate()
		serverProps.name = "ServerProperties"
		add_child(serverProps)
	else:
		Global.isServer = false		
		peer.create_client(serverHost, port)
		multiplayer.multiplayer_peer = peer
	
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
