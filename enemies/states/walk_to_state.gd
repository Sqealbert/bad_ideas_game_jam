class_name WalkToState extends BaseState

func run(_delta): ## a base state for a state functionality returns true when all works, returns false for special logoi
	var dir = Vector2()
	if parent.target.position.x < parent.position.x:
		dir.x = -1
	else:
		dir.x = 1

	parent.velocity.x = dir.x * parent. SPEED		

	if parent.is_on_wall():
		parent.velocity.y = -parent.jump_strenght
