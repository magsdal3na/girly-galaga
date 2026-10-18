extends CharacterBody2D

@export var speed = 400.0
@export var rotation_speed = 4
@export var acceleration = 600.0
@export var drag_factor = 2.0

var rotation_direction = 0

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func get_input():
	rotation_direction = Input.get_axis("move_left", "move_right")
	#velocity = transform.x * Input.get_axis("move_down", "move_up") * speed
	
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
	#input_vector.x = Input.get_axis("move_left", "move_right")
	#input_vector.y = Input.get_axis("move_up", "move_down")
	#input_vector = input_vector.normalized()
	
	#applies acceleration if pushing buttons
	if input_vector != Vector2.ZERO:
		velocity += input_vector * acceleration * delta
		velocity = velocity.limit_length(speed)
	
	#applies linear drag for dampening
	#smoothly slows the ship when not accelerating
	velocity = velocity.lerp(Vector2.ZERO, drag_factor * delta)
	
	move_and_slide()
