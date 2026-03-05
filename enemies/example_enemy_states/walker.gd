extends BaseEnemy


func AI(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		turn()
		
	current_state.run(delta)
	
func _on_state_switch_timer_timeout() -> void:
	current_state_index = !current_state_index # switches between 0 and 1
	
	current_state = $States.get_children()[current_state_index]
	
