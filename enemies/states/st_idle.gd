class_name ST_Idle extends BaseState

func run(_delta):
	parent.velocity.x = 0
	return true
