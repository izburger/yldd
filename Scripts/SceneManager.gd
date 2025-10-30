extends Node
@onready var player: Node2D = $Player
@onready var transition = $FadeIn

func _ready() -> void:

	if InkStore.story == null:
		var f := FileAccess.open("res://dialogue/main.json", FileAccess.READ)
		if f:
			InkStore.ensure_story(f.get_as_text())

	InkStore.set_ink_var("mc", Global.player_name)
  
	transition.play("fade_in")
  
	var spawn_id := GameStates.consume_next_spawn_id()
	if spawn_id == "":
		return
	var spawn := _find_spawn(spawn_id)
	if spawn:
		player.global_position = spawn.global_position
	else:
		push_warning("Spawn id '%s' not found" % spawn_id)

func _find_spawn(id: String) -> Marker2D:
	for n in get_tree().get_nodes_in_group("spawn_points"):
		if n is Marker2D and n.get("spawn_id") == id:
			return n
	return null
