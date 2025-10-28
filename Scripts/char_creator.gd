extends Node2D

@onready var transition = $creatorscreen/ColorRect/Transition
@onready var textpopup = $creatorscreen/TextPopUp


func _ready():
	transition.play("fade_in")
	

#change scene 
func _on_confirm_pressed():
	transition.play("fade_out")
	await get_tree().create_timer(1.0).timeout
	$creatorscreen/TextPopUp/Label.text = "Wonderful, you look lovely " + Global.player_name + "."
	textpopup.play("show")
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Week1/office_case_1.tscn")
