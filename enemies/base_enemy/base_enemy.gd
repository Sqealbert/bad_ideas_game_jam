extends CharacterBody2D
class_name BaseEnemy

const SPEED = 100.0
var curent_direction:Vector2 = Vector2(1, 0)

# state handeling
var current_state
@export var current_state_index: int = 999

var target: Node2D

func initialise_states():
		# inicialise states if begining state exists else return error
	if current_state_index != 999:
		current_state = $States.get_children()[current_state_index]
		for state in $States.get_children():
			state.init(self)
	elif $States.get_children().size(): # if has children raise an error
		push_error("Enemy " + self.name + " has no beginning state")
	
	
func _ready() -> void:
	initialise_states()
	
func turn():
	curent_direction.x *= -1

func _physics_process(delta: float) -> void:
	
	# do AI logic
	AI(delta)


	move_and_slide()

func AI(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	velocity.x = SPEED * curent_direction.x

	
	if is_on_wall():
		turn()

func ledge_collision_detect(_body: Node2D):
	turn()
