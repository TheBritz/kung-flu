extends StaticBody2D

var serverProperties: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	serverProperties = get_node("../ServerProperties")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if serverProperties == null:
		serverProperties = get_node("../ServerProperties")
	else:
		position = Vector2(0, serverProperties.RoomHeight)
