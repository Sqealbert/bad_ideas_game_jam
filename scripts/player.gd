extends CharacterBody2D

@export var speed: int = 400
#h is short for horizontal
var h_direction: float
var facing: float = -1.0

signal attack(dir: Vector2)

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta: float) -> void:
	get_input()
	velocity.y += get_player_gravity() * delta
	velocity.x = h_direction * speed
	move_and_slide()

func get_player_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func get_input():
	h_direction = Input.get_axis("move_left","move_right")
	if h_direction:
		facing = h_direction
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	if Input.is_action_just_pressed("attack"):
		attack.emit(Vector2(facing,0))
	
func jump():
	velocity.y = jump_velocity
