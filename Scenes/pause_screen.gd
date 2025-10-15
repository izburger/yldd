extends Control

@onready var background = $PauseScreen

func _ready():
	$AnimationPlayer.play("RESET")
#resume and pause are in funcs to make managine the animations easier
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func  testEscape():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:# this checks if the screen is currently paused
		background.visible = true
		print("lol")
		pause()


	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:# if it's currently paused
		resume()
	 	

func _on_resume_pressed() -> void:
	resume()


func _on_restart_day_pressed() -> void:
	resume()
	get_tree().reload_current_scene()#reloads scene which should be the day


func _on_quit_pressed() -> void:
	get_tree().quit()
