extends CharacterBody2D

# Node References
@onready var body = $Skeleton/body
@onready var hair = $Skeleton/hair
@onready var outfit = $Skeleton/outfit

# AnimationPlayer node
@onready var animation_player = $AnimationPlayer

var last_direction = Vector2.ZERO
const speed = 400

func _ready():
	initialize_player()
	

func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# store last direction
	if direction != Vector2.ZERO:
		last_direction = direction
	
	# update direction and velocity 
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		
	if direction.y != 0:
		velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed * delta)
		
	# pick animation
	var next_anim = ""
	if direction.x != 0:
		# reuse walk_left but flip if going right
		next_anim = "walk_left"
		set_flip(direction.x > 0)
	elif direction.y < 0:
		next_anim = "walk_up"
		set_flip(false)
	elif direction.y > 0:
		next_anim = "walk_down"
		set_flip(false)
	elif direction == Vector2.ZERO:
		if last_direction.x != 0:
			next_anim = "idle_left"
			set_flip(last_direction.x > 0)
		elif last_direction.y < 0:
			next_anim = "idle_up"
			set_flip(false)
		elif last_direction.y > 0:
			next_anim = "idle_down"
			set_flip(false)
	
	# play only if animation changed
	if next_anim != "" and animation_player.current_animation != next_anim:
		animation_player.play(next_anim)
		
	
	#stop animation
		# update direction and velocity 
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = 0.0

	if direction.y != 0:
		velocity.y = direction.y * speed
	else:
		velocity.y = 0.0
	
	move_and_slide()
	

	
func initialize_player():
	# BODY
	if Global.bodies_collection_BIG.has(Global.selected_body_BIG):
		body.texture = Global.bodies_collection_BIG[Global.selected_body_BIG]
	else:
		print("Warning: invalid body key, using default '01'")
		body.texture = Global.bodies_collection_BIG["01"]
	
	body.modulate = Global.selected_body_colour_BIG

	# HAIR
	if Global.hair_collection_BIG.has(Global.selected_hair_BIG):
		hair.texture = Global.hair_collection_BIG[Global.selected_hair_BIG]
	else:
		print("Warning: invalid hair key, using 'none'")
		hair.texture = null
	
	hair.modulate = Global.selected_hair_colour_BIG

	# OUTFIT
	if Global.outfit_collection_BIG.has(Global.selected_outfit_BIG):
		outfit.texture = Global.outfit_collection_BIG[Global.selected_outfit_BIG]
	else:
		print("Warning: invalid outfit key, using default '01'")
		outfit.texture = Global.outfit_collection_BIG["01"]
		


# helper to flip horizontally
func set_flip(should_flip: bool):
	body.flip_h = should_flip
	hair.flip_h = should_flip
	outfit.flip_h = should_flip
