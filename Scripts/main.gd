extends Node2D

@onready var transition = $FadeIn

# Called when the node enters the scene tree for the first time.
func _ready():
	transition.play("fade_in")
	print("Your taste is: " + Global.your_taste)
	print("Your ganda is: " + Global.your_ganda)
	print("Your experience is: " + Global.your_experience)
	print("Your feeling is: " + Global.your_feeling)
	print("Your betrayl thing is: " + Global.your_betryal)
