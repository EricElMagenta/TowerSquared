extends State
class_name Fall

func Enter():
	pass

func Physics_Update(delta:float):
	# Obtener los inputs para moverse
	var vector = parent.get_input_vector()
	parent.move(delta)
	
	# Cambiar estado al tocar el suelo
	if parent.is_on_floor(): state_transition.emit(self, "Idle")

func Exit():
	pass
