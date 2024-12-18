extends State
class_name Idle

func Enter():
	pass

func Physics_Update(delta: float):
	# Obtener los inputs para moverse
	var vector = parent.get_input_vector()
	parent.move(delta)
	
	# Cambiar de estado al caminar
	if vector != Vector2.ZERO:
		state_transition.emit(self, "walk")
	
	# Cambiar de estado al saltar
	if parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		state_transition.emit(self, "jump")
	
func Exit():
	pass
