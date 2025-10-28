extends Node2D



func _on_button_toggled(toggled_on: bool) -> void:
	Global.your_betryal = "Sadness"
	print(Global.your_betryal)


func _on_button_2_toggled(toggled_on: bool) -> void:
	Global.your_betryal = "Suprise"
	print(Global.your_betryal)


func _on_button_3_toggled(toggled_on: bool) -> void:
	Global.your_betryal = "Nothing"
	print(Global.your_betryal)


func _on_button_4_toggled(toggled_on: bool) -> void:
	Global.your_betryal = "They wont betray me"
	print(Global.your_betryal)


func _on_confirm_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
