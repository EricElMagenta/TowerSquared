extends State
class_name Walk

func Enter():
	pass

func Physics_Update(delta: float):
	# Obtener los inputs para moverse
	var vector = parent.get_input_vector()
	parent.move(delta)
	
	# Cambiar estado al detenerse
	if vector == Vector2.ZERO:
		state_transition.emit(self, "Idle")
	
	# Cambiar de estado al saltar
	if parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		parent.jump()
		state_transition.emit(self, "jump")
		
func Exit():
	pass
