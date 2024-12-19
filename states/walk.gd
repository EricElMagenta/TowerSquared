extends State
class_name Walk

func Enter():
	pass

func Physics_Update(delta:float):
	# Obtener los inputs para moverse
	var vector = parent.get_direction()
	parent.move(delta)
	
	# Cambiar estado al detenerse
	if vector == Vector2.ZERO:
		state_transition.emit(self, "Idle")
	
	# Cambio de estado al empezar a caer
	if parent.velocity.y > 0: state_transition.emit(self, "Fall")
	
	# Cambiar de estado al saltar
	if parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		parent.jump()
		state_transition.emit(self, "jump")
		
func Exit():
	pass
