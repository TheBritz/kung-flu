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

func _ready() -> void:
	capsRegex.compile('^[A-Z]')
	if multiplayer.is_server:
		print("Server properties created")
	else:
		print("Remove server properties synced")
	#label = get_node("ServerPropertiesDisplay")
	label = get_child(1) as RichTextLabel
	label.text = str(PlayerSpeed)
	var thisScript: GDScript = get_script()
	var textY: float = 0
	for propertyInfo in thisScript.get_script_property_list():
		var propertyName: String = propertyInfo.name
		var result = capsRegex.search(propertyName)
		if result:
			var propertyValue = get(propertyName)
			label.text = label.text + propertyName + " = " + str(propertyValue) + "\n"
			var spinner: ServerPropertySpinner = ServerPropertySpinner.create(propertyName, float(propertyValue))
			add_child(spinner)
			spinner.position = Vector2(200, textY)
			textY+=50 
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		PlayerSpeed += 25
	if Input.is_action_just_pressed("ui_down"):
		PlayerSpeed -= 25

func _process(delta: float) -> void:
	label.text = ""
	var thisScript: GDScript = get_script()
	for propertyInfo in thisScript.get_script_property_list():
		var propertyName: String = propertyInfo.name
		var result = capsRegex.search(propertyName)
		if result:
			var propertyValue = get(propertyName)
			label.text = label.text + propertyName + " = " + str(propertyValue) + "\n"
