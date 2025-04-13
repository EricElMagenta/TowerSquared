extends State
class_name Dead

func Enter():
	parent.ded()
	parent.player_animations(self.name)

func Physics_Update(_delta:float):
	pass
	
func Exit():
	pass
