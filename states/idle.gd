extends State
class_name Idle

func Enter():
	pass

func Physics_Update(delta: float):
	var vector = parent.get_input_vector()
	parent.move(delta)
	if vector != Vector2.ZERO:
		state_transition.emit(self, "walk")
	
func Exit():
	pass
