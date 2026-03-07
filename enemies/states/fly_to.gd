class_name ST_FlyTo extends BaseState

func run(_delta):
	if (parent.target.position - parent.position).length() < 10: # very close
		return false

	# Set the movement target for the agent
	parent.set_movement_target(parent.target.position)
	
	# Get the next path position from the navigation agent
	var next_pos: Vector2 = parent.navigation_agent.get_next_path_position()
	
	# Move the enemy along the navigation path
	var direction = (next_pos - parent.global_position).normalized()
	parent.velocity = direction * parent.SPEED
	
	return true
