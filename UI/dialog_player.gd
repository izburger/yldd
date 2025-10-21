extends CanvasLayer

@export_file("*.json") var scene_text_file: String

var scene_text = {}
var selected_text = []
var in_progress = false

@onready var background = $MarginContainer
@onready var choicebackground = $MarginContainer
@onready var text_label = $MarginContainer/MarginContainer/HBoxContainer/MainText

func _ready():
	background.visible = false
	choicebackground.visible = false
	scene_text = JSON.parse_string(FileAccess.open(scene_text_file, FileAccess.READ).get_as_text())
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))

##func load_scene_text() -> Dictionary:
#	var file := FileAccess.open(scene_text_file, FileAccess.READ)
#	if file:
#		var text := file.get_as_text()
#		var result = JSON.parse_string(text) as Dictionary
#		if result["error"] == OK:
#			return result["result"]
#		else:
#			push_error("JSON parse error: %s" % result["error_string"])
#	else:
#		push_error("Could not open file: %s" % scene_text_file)
#	return {}

func show_text():
	text_label.text = selected_text.pop_front()

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	text_label.text = ""
	background.visible = false
	choicebackground.visible = false
	in_progress = false
	get_tree().paused = false

func on_display_dialog(dialog_key: String):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_text = get_nested_value(scene_text, dialog_key.split(".")).duplicate()
		show_text() 


func get_nested_value(data: Dictionary, keys: Array) -> Variant:
	var current = data
	for key in keys:
		if current.has(key):
			current = current[key]
		else:
			push_error("Key not found in JSON: %s" % key)
			return []
	return current
