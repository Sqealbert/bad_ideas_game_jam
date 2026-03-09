class_name PlasticSoldierEnemy extends BaseEnemy

var jump_strenght = 500

var patrol_points
var patrol_index

var following = false
var in_line_of_sight = false

func _ready() -> void:
	initialise_states()
	patrol_points = [Node2D.new(), Node2D.new()]
	patrol_points[0].position = $PatrollPoint1.global_position
	patrol_points[1].position = $PatrollPoint2.global_position
	patrol_index = 0
	
func AI(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if target:
		current_state.run(delta)
		if following:
			pass # implement shooting!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		elif (target.position - position).length() < 100:
			switch_patrol_points()
	else:
		switch_patrol_points()
		
func switch_patrol_points():
	patrol_index += 1
	if len(patrol_points) == patrol_index:
		patrol_index = 0
	target = patrol_points[patrol_index]

	
