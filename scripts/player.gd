extends CharacterBody2D

const HEART_SCENE = preload("res://scenes/heart.tscn")

@export var speed: int = 400
#h is short for horizontal
@export var max_health: int
@onready var current_health: int = max_health

var h_direction: float
var facing: float = -1.0

signal attack(dir: Vector2)

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _ready() -> void:
	set_hearts(current_health)
	
func _physics_process(delta: float) -> void:
	get_input()
	velocity.y += get_player_gravity() * delta
	velocity.x = h_direction * speed
	move_and_slide()

func set_hearts(value: int):
	for heart in $HeartContainer/HFlowContainer.get_children():
		heart.queue_free()
	for i in value:
		var heart = HEART_SCENE.instantiate()
		$HeartContainer/HFlowContainer.add_child(heart)

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
		
	$Sprite2D.flip_h = true if facing == 1.0 else false
	
func jump():
	velocity.y = jump_velocity

func hit():
	$AnimationPlayer.play("damage_flash")
	current_health -= 1
	set_hearts(current_health)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	hit()
