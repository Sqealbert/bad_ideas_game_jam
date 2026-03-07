class_name BaseState extends Node

var parent: BaseEnemy

func init(enemyparent: BaseEnemy):
	parent = enemyparent
	
func run(_delta): ## a base state for a state functionality returns true when all works, returns false for special logoi
	pass
