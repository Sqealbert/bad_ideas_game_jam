class_name BaseState extends Node

var parent: BaseEnemy

func init(enemyparent: BaseEnemy):
	parent = enemyparent
	
func run(_delta):
	print("base")
	pass
