extends Area2D

@export var dialog_key = ""
var area_active = false
var played = false

func _ready():
	set_process_input(true)

func _input(event):
	if area_active and not played:
		played = true
		SignalBus.emit_signal("display_dialog", dialog_key)
		
func _on_area_entered(area: Area2D) -> void:
	area_active = true

func _on_area_exited(area: Area2D) -> void:
	area_active = false
	print("Exited dialog zone!")
