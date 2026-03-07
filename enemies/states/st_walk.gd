class_name ST_Walk extends BaseState

func run(_delta):
	parent.velocity.x = parent.SPEED * parent.curent_direction.x	
	return true
