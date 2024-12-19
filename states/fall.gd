extends State
class_name Fall

func Enter():
	pass

func Physics_Update(delta:float):
	parent.move(delta)
	
	# Cambiar estado al tocar el suelo
	if parent.is_on_floor(): state_transition.emit(self, "Idle")

func Exit():
	pass
