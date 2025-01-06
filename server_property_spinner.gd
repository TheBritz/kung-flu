class_name ServerPropertySpinner

extends SpinBox

const scene: PackedScene = preload("res://server_property_spinner.tscn")
var serverPropertyName: String
var serverProperties: ServerProperties

func _init() -> void:
	serverProperties = get_parent()
	print(serverProperties)

static func create(serverPropertyName: String, serverPropertyValue: float) -> ServerPropertySpinner:
	var spinner: ServerPropertySpinner = scene.instantiate()
	if serverPropertyValue < .5:
		spinner.step = .01
	elif serverPropertyValue < 1:
		spinner.step = .1
	elif serverPropertyValue > 20:
		spinner.step = 5
	elif serverPropertyValue > 50:
		spinner.step = 10
	elif serverPropertyValue > 200:
		spinner.step = 25
	spinner.serverPropertyName = serverPropertyName
	spinner.max_value = serverPropertyValue * 100
	spinner.value = serverPropertyValue
	spinner.prefix = serverPropertyName + " "
	spinner.size = Vector2(300, 40) 
	return spinner

func _value_changed(new_value: float) -> void:
	if ! serverProperties:
		serverProperties = get_parent()
	serverProperties.set(serverPropertyName, new_value)
