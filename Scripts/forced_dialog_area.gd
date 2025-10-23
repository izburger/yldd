extends Area2D

@export var dialog_key = ""
@export var dia_k = ""
var area_active = false

func _ready():
	set_process_input(true)

func _input(event):
	if area_active
		SignalBus.emit_signal("display_dialog", dialog_key)
		
func _on_area_entered(area: Area2D) -> void:
	area_active = true

func _on_area_exited(area: Area2D) -> void:
	area_active = false
	print("Exited dialog zone!")
