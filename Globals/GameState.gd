extends Node

var next_spawn_id: String = ""   #example use "sonny_office"

func change_scene_with_spawn(scene_path: String, spawn_id: String) -> void:
	next_spawn_id = spawn_id
	get_tree().paused = false
	call_deferred("_do_change", scene_path)

func _do_change(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)

	
func consume_next_spawn_id() -> String:
	var id := next_spawn_id
	next_spawn_id = ""
	return id