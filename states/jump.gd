extends State
class_name Jump

func Enter():
	# Saltar al iniciar el estado
	parent.jump()
	
func Physics_Update(delta:float):
	parent.move(delta)
	
	# Cambio de estado al empezar a caer
	if parent.velocity.y > 0: state_transition.emit(self, "Fall")

func Exit():
	pass
