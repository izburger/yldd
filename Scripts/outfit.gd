extends Node2D

@onready var outfit_sprite = $Sprite2D

#keys

var outfit_keys = []
#var colour_keys = []
var current_outfit_index = 0 
#var current_colour_index = 0 

func _ready():
	set_sprite_keys()
	update_sprite()

#set outfit
func set_sprite_keys():
	outfit_keys = Global.outfit_collection.keys()

#update texture and modulate
func update_sprite():
	var current_sprite = outfit_keys[current_outfit_index]
	outfit_sprite.texture = Global.outfit_collection[current_sprite]
	#outfit_sprite.modulate = Global.colour_options[current_colour_index]
	
	Global.selected_outfit = current_sprite
	#Global.selected_outfit_colour = Global.colour_options[current_colour_index]
	


#change outfit 
func _on_collection_button_pressed():
	current_outfit_index = (current_outfit_index + 1) % outfit_keys.size()
	update_sprite() 

#change colour 
#func _on_colour_button_pressed():
#	current_colour_index = (current_colour_index + 1 ) % Global.colour_options.size()
#	update_sprite()
