class_name ServerProperties

extends Node

var capsRegex: RegEx = RegEx.new()
var label: RichTextLabel = null

#Server properties should be defined here and be Pascal case
# Max player speed
@export var PlayerSpeed = 400
# Base acceleration rate
@export var PlayerAccelBase = 25
# Multiplier applied to acceleration when changing direction
@export var PlayerAccelChangeOfDirMult = 4
# Decceleration ratio per frame when no inputs are active
@export var PlayerDeccelDrift = .05
# Decceleration ratio per frame when inputs are active
@export var PlayerDeccelActive = .1
@export var PlayerHealth = 100
@export var RoomWidth: float = 2000
@export var RoomHeight: float = 1500

func _ready() -> void:
	capsRegex.compile('^[A-Z]')
	if Global.isServer:
		var thisScript: GDScript = get_script()
		var textY: float = 10
		for propertyInfo in thisScript.get_script_property_list():
			var propertyName: String = propertyInfo.name
			var result = capsRegex.search(propertyName)
			if result:
				var propertyValue = get(propertyName)
				var spinner: ServerPropertySpinner = ServerPropertySpinner.create(propertyName, float(propertyValue))
				add_child(spinner)
				spinner.position = Vector2(10, textY)
				textY+=50
	else:
		label = get_child(1)

func _process(delta: float) -> void:
	if !Global.isServer:
		label.text = ""
		var thisScript: GDScript = get_script()
		for propertyInfo in thisScript.get_script_property_list():
			var propertyName: String = propertyInfo.name
			var result = capsRegex.search(propertyName)
			if result:
				var propertyValue = get(propertyName)
				label.text = label.text + propertyName + " = " + str(propertyValue) + "\n"
