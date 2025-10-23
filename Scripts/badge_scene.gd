extends Node2D

@onready var transition = $FadeOut
@onready var textpopup = $AnimationPlayer
@onready var name_box = $TextureRect/TextEdit

var player_name =""

func _on_text_edit_text_changed():
	player_name = name_box.text

func _on_confirm_name_pressed():
	Global.player_name = player_name
	
	if player_name.strip_edges() == "":
		print("please enter name")
	else:
		transition.play("fade_out_daniel")
		await get_tree().create_timer(1.0).timeout
		textpopup.play("text")
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://Scenes/char_creator.tscn")
		print(player_name)


#func _on_transition_animation_finished(_anim_name):
#	get_tree().change_scene_to_file("res://Scenes/char_creator.tscn")
