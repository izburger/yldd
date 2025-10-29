extends CanvasLayer

@export_file("*.json") var scene_text_file: String
#@export_file("*.json") var ink_file_path: String
var ink_story: InkStory

var scene_text = {}
var selected_text = []
var in_progress = false

@onready var _test_marker_ready = true
@onready var background = $MarginContainer
@onready var choicebackground = $MarginContainer
@onready var text_label = $MarginContainer/MarginContainer/HBoxContainer/MainText
@onready var choice_list = $Test
@onready var btn = []


@export var story_key: String = "main"
const SAVE_DIR := "user://"
func _save_path() -> String:
	return "%sink_state_%s.json" % [SAVE_DIR, story_key]

func _save_ink() -> void:
	if ink_story == null: return
	var json := ""
	if ink_story.has_method("save_state_to_json"):
		json = ink_story.save_state_to_json()
	elif ink_story.has_method("state_to_json"):
		json = ink_story.state_to_json()
	var f := FileAccess.open(_save_path(), FileAccess.WRITE)
	if f: f.store_string(json)

func _load_ink() -> void:
	if not FileAccess.file_exists(_save_path()): return
	var f := FileAccess.open(_save_path(), FileAccess.READ)
	if not f: return
	var json := f.get_as_text()
	if json == "": return
	# Most Godot-Ink builds expose load_state_from_json with this name:
	ink_story.load_state_from_json(json)


func _ready():
	background.visible = false
	choicebackground.visible = false
	choice_list.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

	var file := FileAccess.open(scene_text_file, FileAccess.READ)
	if file:
		var json_text := file.get_as_text()
		InkStore.ensure_story(json_text)
		ink_story = InkStore.story
		print("Ink story loaded via InkStore!")
	else:
		push_error("Failed to open Ink file: %s" % scene_text_file)

	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))
	await get_tree().process_frame


	##scene_text = JSON.parse_string(FileAccess.open(scene_text_file, FileAccess.READ).get_as_text())
	#SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))

	#await get_tree().process_frame
	print("choice_list =", choice_list, " class=", choice_list and choice_list.get_class())
 

func continue_story(): 
	#for button in choice_list.get_children(): 
	#	button.remove_child(button) 
	#	choice_list.visible = false 

	_clear_choices()

	if ink_story.can_continue: 
		text_label.text = ink_story.continue_story() 
		InkStore.save_state()
	else: 
		if ink_story.current_choices.size() > 0: 
			show_choices() 
		else: 
			finish() 
			

func show_choices(): 
	await _clear_choices()
	choice_list.visible = true 

	print("choices = ", ink_story.current_choices.size())
	for i in ink_story.current_choices.size():
		var ch = ink_story.current_choices[i]
		var idx := int(ch.index)
		print(" row i=", i, "  ch.index=", ch.index, "  text='", ch.text, "'")
		var b  = Button.new()
		b.text = ch.text
		b.focus_mode = Control.FOCUS_ALL
		b.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		b.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		b.focus_mode = Control.FOCUS_NONE
		b.mouse_filter = Control.MOUSE_FILTER_STOP

		
		b.pressed.connect(Callable(self, "_on_choice_pressed").bind(idx))


		choice_list.add_child(b)




	##for i in range(ink_story.current_choices.size()): 
	#	var choice_text = ink_story.current_choices[i]["text"] 
	#	var button := Button.new() 
	#	button.text = choice_text 
	#	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL 
	#	button.focus_mode = Control.FOCUS_NONE 
	#	button.mouse_filter = Control.MOUSE_FILTER_STOP 
		
	#	var idx := i 
	#	button.pressed.connect(func() -> void: 
	#		print("Pressed choice:", idx) 
	#		for child in choice_list.get_children(): 
	#			child.queue_free() 
	#			choice_list.visible = false 

	#		#await get_tree().create_timer(0.05).timeout
	#		ink_story.choose_choice_index(idx) 
	#		call_deferred("continue_story") 
	#	) 
	#	await get_tree().process_frame
	#	choice_list.add_child(button)


#func index_choose(button):
#	var index = btn.find(button)
#	if index != -1:
#		_on_choice_selected(index)



#func _on_choice_selected(index: int):
#	print("Button pressed:", index)
#	for button in choice_list.get_children():
#		choice_list.remove_child(button)
#	ink_story.choose_choice_index(index)
#	continue_story()

func _on_choice_pressed(ink_idx: int) -> void:
	#which branch we chose, then advance again
	ink_story.choose_choice_index(ink_idx)
	InkStore.save_state()
	continue_story()


func finish():
	text_label.text = ""
	background.visible = false
	choicebackground.visible = false
	in_progress = false
	get_tree().paused = false
	SignalBus.emit_signal("dialogue_closed")

func on_display_dialog(dialog_key: String):
	if in_progress:
		continue_story()
	else:
		in_progress = true
		get_tree().paused = true
		background.visible = true
		ink_story.choose_path_string(dialog_key)
		continue_story()
		#show_text() 


func get_nested_value(data: Dictionary, keys: Array) -> Variant:
	var current = data
	for key in keys:
		if current.has(key):
			current = current[key]
		else:
			push_error("Key not found in JSON: %s" % key)
			return []
	return current


func _notification(what):
	if what == NOTIFICATION_PREDELETE or what == NOTIFICATION_WM_CLOSE_REQUEST:
		InkStore.save_state()

func _clear_choices():
	for c in choice_list.get_children():
		c.queue_free()
