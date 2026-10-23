extends CharacterBody2D

@export var speed = 400.0
@export var rotation_speed = 4
@export var acceleration = 600.0
@export var drag_factor = 2.0

@onready var star_label = %StarCounter

var rotation_direction = 0

var star_counter = 0

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func get_input():
	rotation_direction = Input.get_axis("move_left", "move_right")
	
func _physics_process(delta: float) -> void:
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	
	var thrust_input := Input.get_axis("move_down", "move_up")
	
	if thrust_input > 0:
		velocity += transform.x * acceleration * delta
		velocity = velocity.limit_length(speed)
	elif thrust_input < 0:
		velocity -= transform.x * acceleration * delta
		velocity = velocity.limit_length(speed)
	
	#gets input direction
	var input_vector := Vector2.ZERO
	
	#applies acceleration if pushing buttons
	if input_vector != Vector2.ZERO:
		velocity += input_vector * acceleration * delta
		velocity = velocity.limit_length(speed)
	
	#applies linear drag for dampening
	#smoothly slows the ship when not accelerating
	velocity = velocity.lerp(Vector2.ZERO, drag_factor * delta)
	
	move_and_slide()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("collectible-stars"):
		set_count(star_counter + 1)
		print(star_counter)
	
func set_count(new_star_count: int) -> void:
	star_counter = new_star_count
	star_label.text = str(star_counter)
	
