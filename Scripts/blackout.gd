extends Area2D

@export_node_path("Node2D") var npc_path: NodePath
@onready var npc: Node2D = get_node(npc_path) if npc_path != NodePath("") else null
@onready var fade := get_tree().get_first_node_in_group("fade")
@export var dialog_key = ""
@export var x = 0
@export var y = 0

var inside := false
var played = false

func _ready() -> void:
	set_process_input(true)

func _unhandled_input(event: InputEvent) -> void:
	if inside and not played:
		played = true
		await run_beats()

func _on_area_entered(area: Area2D) -> void:
	inside = true

func _on_area_exited(area: Area2D) -> void:
	inside = false
	print()


func run_beats() -> void:
	await fade.blackout(0.4)    
	npc.global_position = Vector2(x, y)  
	SignalBus.emit_signal("display_dialog", dialog_key)
	await SignalBus.dialogue_closed
	await fade.blackout(0.4) 
	npc.global_position = Vector2(1740, 1740)  

