extends Node

var capsRegex: RegEx = RegEx.new()
var label: RichTextLabel = null

#Server properties should be defined here and be Pascale case
@export var PlayerSpeed = 400
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
