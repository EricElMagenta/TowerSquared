extends State
class_name Idle

func Enter():
	pass

func Physics_Update(delta:float):
	# Obtener los inputs para moverse
	var vector = parent.get_direction()
	parent.move(delta)
	
	
	# Cambiar de estado al saltar
	if parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		state_transition.emit(self, "jump")
		
	# Cambiar de estado al caminar
	elif vector != Vector2.ZERO:
		state_transition.emit(self, "walk")
	

	
	# Cambio de estado al empezar a caer
	if parent.velocity.y > 0: state_transition.emit(self, "Fall")
	
func Exit():
	pass
