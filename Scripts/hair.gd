extends Node2D

@onready var hair_sprite = $Sprite2D

#keys

var hair_keys = []
var colour_keys = []
var current_hair_index = 0 
var current_colour_index = 0 

func _ready():
	set_sprite_keys()
	update_sprite()

#set hair
func set_sprite_keys():
	hair_keys = Global.hair_collection.keys()

#update texture and modulate
func update_sprite():
	var current_sprite = hair_keys[current_hair_index]
	if current_sprite == "none":
		hair_sprite.texture = null
	else:
		hair_sprite.texture = Global.hair_collection[current_sprite]
		hair_sprite.modulate = Global.hair_colour_options[current_colour_index]
	
	Global.selected_hair = current_sprite
	Global.selected_hair_colour = Global.hair_colour_options[current_colour_index]
	


#change hair colour 
func _on_colour_button_pressed():
	current_colour_index = (current_colour_index + 1 ) % Global.hair_colour_options.size()
	update_sprite()


func _on_hair_button_pressed():
	current_hair_index = (current_hair_index + 1) % hair_keys.size()
	update_sprite()
