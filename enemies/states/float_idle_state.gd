class_name ST_FloatIdle extends BaseState

func run(_delta):
	parent.velocity.y = sin(Time.get_ticks_usec()/float(10**6)) * parent.float_offset
	parent.velocity.x = 0
	return true
