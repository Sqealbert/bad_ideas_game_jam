extends StaticBody2D

var direction: Vector2 = Vector2.ZERO

var attack_target: float
var start_pos: float
var speed: int = 200
var attacking: bool = false
var retracting: bool = false

@export var attack_length: float
@export var attack_speed: float
@export var retract_speed: float

func attack(dir: Vector2):
	direction = dir
	
func _physics_process(delta: float) -> void:
	if attacking:
		if global_position.x > attack_target:
			global_position.x -= direction.x * speed * delta
		else:
			retracting = true
			attacking = false
	elif retracting:
		if global_position.x < start_pos:
			global_position.x += direction.x * speed * delta
		else:
			retracting = false

func _on_player_attack(dir: Vector2) -> void:
	if not attacking or retracting:
		attacking = true
		start_pos = global_position.x
		attack_target = global_position.x - (dir.x * 100)
		attack(dir)
