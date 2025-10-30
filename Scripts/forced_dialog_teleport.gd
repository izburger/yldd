extends Area2D

@export var dialog_key = ""
@export_file("*.tscn") var target_scene: String = "res://Scenes/Week1/office_1_case_1_lunch.tscn"
@export var spawn_id := "mc_office"
var area_active = false
var played = false

func _ready():
    set_process_input(true)

func _input(event):
    if area_active and not played:
        played = true
        SignalBus.emit_signal("display_dialog", dialog_key)
        await SignalBus.dialogue_closed

        var gs := get_node_or_null("/root/GameState")
        if gs and spawn_id != "":
            gs.change_scene_with_spawn(target_scene, spawn_id)
        else:
			#get_tree().change_scene_to_file(target_scene)
            GameStates.change_scene_with_spawn(target_scene, spawn_id)
		
func _on_area_entered(area: Area2D) -> void:
    area_active = true

func _on_area_exited(area: Area2D) -> void:
    area_active = false
    print("Exited dialog zone!")
