extends Node2D

@onready var transition = $FadeIn

# Called when the node enters the scene tree for the first time.
func _ready():
	transition.play("fade_in")
