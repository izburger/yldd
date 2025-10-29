extends CanvasLayer
@onready var rect: ColorRect = $FadeRect

func _enter_tree() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func fade_out(duration: float = 0.35) -> void:
	rect.visible = true
	var tw := create_tween()
	tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(rect, "modulate:a", 1.0, duration)
	await tw.finished


func fade_in(duration: float = 0.35) -> void:
	var tw := create_tween()
	tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(rect, "modulate:a", 0.0, duration)
	await tw.finished
	rect.visible = false


func blackout(hold_time: float = 0.15, dur: float = 0.35) -> void:
	await fade_out(dur)
	var tw := create_tween()
	tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_interval(hold_time)
	await tw.finished
	await fade_in(dur)
