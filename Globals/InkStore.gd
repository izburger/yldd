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
            if story.has_method("load_state_from_json"):
                story.load_state_from_json(state_json)

func save_state():
    if story == null: return
    if story.has_method("save_state_to_json"):
        state_json = story.save_state_to_json()
    elif story.has_method("state_to_json"):
        state_json = story.state_to_json()