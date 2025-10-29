extends Area2D

@export_file("*.tscn") var target_scene: String
@export var exit_spawn_id: String = ""
@onready var prompt: Label = $PromptLabel

var _player_inside := false
#var _cooldown := false 

func _ready() -> void:
	set_process_input(true)
	prompt.visible = false

func _on_area_entered(area: Area2D) -> void:
	_player_inside = true
	prompt.visible = true
	print("entered door zone!")

func _on_area_exited(area: Area2D) -> void:
	_player_inside = false
	prompt.visible = false
	print("exited door zone!")

func _unhandled_input(event: InputEvent) -> void:
	if _player_inside and Input.is_action_just_pressed("interact"):
		if target_scene == "" or exit_spawn_id == "":
			push_error("Door missing target_scene or exit_spawn_id")
			return
		prompt.visible = false
		GameStates.change_scene_with_spawn(target_scene, exit_spawn_id)

#func _change_scene_safe() -> void:
#	get_tree().paused = false
#	call_deferred("_do_change")

#func _do_change() -> void:
#	if target_scene == "" or not FileAccess.file_exists(target_scene):
#		push_error("DoorArea2D: target_scene not set or missing.")
#		#_cooldown = false
#		return
#	get_tree().change_scene_to_file(target_scene)
