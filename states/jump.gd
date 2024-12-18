extends State
class_name Jump

func Enter():
	# Saltar al iniciar el estado
	parent.jump()
	
func Physics_Update(delta: float):
	# Obtener los inputs para moverse
	var vector = parent.get_input_vector()
	parent.move(delta)
	
	
	if parent.is_on_floor(): state_transition.emit(self, "Idle")

func Exit():
	pass
