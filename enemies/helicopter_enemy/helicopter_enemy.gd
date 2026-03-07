class_name HelicopterEnemy extends BaseEnemy

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D # Ai navigation

var float_offset = 20
var rotation_offset = deg_to_rad(30)
var rotation_speed = PI/400

var in_line_of_sight = false

func _ready() -> void:
	initialise_states()
		# Make sure to not await during _ready.
	actor_setup.call_deferred()
	
func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(position) # stay in place
	
func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func AI(delta):
	if not current_state.run(delta):
		## in this case indicates that target has been lost
		switch_state()
	rotate_with_speed()
	
	if target and can_see_target(target):
		if current_state == $States/FloatIdleState:
			switch_state()
		
func rotate_with_speed():
	if velocity.x > 0:
		rotate(rotation_speed)
	elif velocity.x < 0:
		rotate(-rotation_speed)
	elif rotation > 0:
		rotate(-rotation/5)
	elif rotation < 0:
		rotate(rotation/5)
	
	rotation =  clampf(rotation, -rotation_offset, rotation_offset)

func switch_state(): ## switches between idle and following based on external signals
	current_state_index = !current_state_index # switches between 0 and 1
	current_state = $States.get_children()[current_state_index]
	$rotFallbackTimer.start()# will get used if going int idle, for follow is uselles

func _on_sigth_area_body_entered(body: Node2D) -> void:
	in_line_of_sight = true
	target = body

func _on_sigth_area_body_exited(body: Node2D) -> void:
	in_line_of_sight = false

	# replace player reference with a ghost Node 2D with the last seen location
	if body == target:
		var last_known_loc = Node2D.new()
		last_known_loc.position = target.position
		target = last_known_loc
