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
@onready var choice_list = $ChoiceContainer/VBoxContainer3
@onready var btn = []

func _ready():
	print("Script loaded, has continue_story:", self.has_method("continue_story"))
	background.visible = false
	choicebackground.visible = false
	choice_list.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	#choice_list.pause_mode = Node.PROCESS_MODE_ALWAYS
	#background.pause_mode = Node.PROCESS_MODE_ALWAYS

	var file := FileAccess.open(scene_text_file, FileAccess.READ)
	if file:
		var json_text := file.get_as_text()
		ink_story = InkStory.new(json_text)
		print("Ink story loaded!")
	else:
		push_error("Failed to open Ink file: %s" % scene_text_file)


	##scene_text = JSON.parse_string(FileAccess.open(scene_text_file, FileAccess.READ).get_as_text())
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))
 

func continue_story(): 
	for button in choice_list.get_children(): 
		button.remove_child(button) 
		choice_list.visible = false 
		
	if ink_story.can_continue: 
		text_label.text = ink_story.continue_story() 
	else: 
		if ink_story.current_choices.size() > 0: 
			show_choices() 
		else: 
			finish() 
			

func show_choices(): 
	choice_list.visible = true 
	for i in range(ink_story.current_choices.size()): 
		var choice_text = ink_story.current_choices[i]["text"] 
		var button := Button.new() 
		button.text = choice_text 
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL 
		button.focus_mode = Control.FOCUS_NONE 
		button.mouse_filter = Control.MOUSE_FILTER_STOP 
		
		var idx := i 
		button.pressed.connect(func() -> void: 
			print("Pressed choice:", idx) 
			for child in choice_list.get_children(): 
				child.queue_free() 
				choice_list.visible = false 

			#await get_tree().create_timer(0.05).timeout
			ink_story.choose_choice_index(idx) 
			call_deferred("continue_story") 
		) 
		await get_tree().process_frame
		choice_list.add_child(button)


func index_choose(button):
	var index = btn.find(button)
	if index != -1:
		_on_choice_selected(index)



func _on_choice_selected(index: int):
	print("Button pressed:", index)
	for button in choice_list.get_children():
		choice_list.remove_child(button)
	ink_story.choose_choice_index(index)
	continue_story()


func finish():
	text_label.text = ""
	background.visible = false
	choicebackground.visible = false
	in_progress = false
	get_tree().paused = false

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
