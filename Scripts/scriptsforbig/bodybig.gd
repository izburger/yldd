extends Node2D

@onready var body_sprite = $Sprite2D

#keys

var body_keys = []
var colour_keys = []
var current_body_index = 0 
var current_colour_index = 0 

func _ready():
	set_sprite_keys()
	update_sprite()

#set body
func set_sprite_keys():
	body_keys = Global.bodies_collection_BIG.keys()

#update texture and modulate
func update_sprite():
	var current_sprite = body_keys[current_body_index]
	body_sprite.texture = Global.bodies_collection_BIG[current_sprite]
	body_sprite.modulate = Global.body_colour_options[current_colour_index]
	
	Global.selected_body_BIG = current_sprite
	Global.selected_body_colour_BIG = Global.body_colour_options[current_colour_index]
	
	

#change body
func _on_collection_button_pressed():
	current_body_index = (current_body_index + 1) % body_keys.size()
	update_sprite()

#change skintone
func _on_colour_button_pressed():
	current_colour_index = (current_colour_index + 1 ) % Global.body_colour_options.size()
	update_sprite()
