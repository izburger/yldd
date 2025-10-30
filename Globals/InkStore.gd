extends Node

var story_json: String 
var story: InkStory
var state_json := ""
var story_key := "main"

func ensure_story(json_text: String):
	if story == null:
		story_json = json_text
		story = InkStory.new(json_text)
		if state_json != "":
			# load saved state if we had one
			if story.has_method("load_state_from_json"):
				story.load_state_from_json(state_json)

func save_state():
	if story == null: return
	if story.has_method("save_state_to_json"):
		state_json = story.save_state_to_json()
	elif story.has_method("state_to_json"):
		state_json = story.state_to_json()

func set_ink_var(name: String, value: Variant) -> void:
	if story == null:
		push_error("InkStory not initialised.")
		return
	if story.has_method("set_variable"):
		story.set_variable(name, value)
		return
	match name:
		"mc":
			story.evaluate_function("SetMC", [value])
		_:
			push_error("No setter for Ink var '%s' and no set_variable API on this wrapper." % name)


func get_ink_var(name: String) -> Variant:
	if story == null:
		push_error("Ink story not initialised.")
		return null
	if story.has_method("get_variable"):
		return story.get_variable(name)
	return null
   
   