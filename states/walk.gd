extends State
class_name Walk

func Enter():
	pass

func Physics_Update(delta:float):
	parent.remaining_air_jumps = parent.max_air_jumps
	
	parent.player_animations(self.name)
	
	# Obtener los inputs para moverse
	var direction = parent.move(delta)
	
	# Cambiar de estado al saltar
	if parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		state_transition.emit(self, "Jump")
	
	# Cambiar estado al detenerse
	elif direction == Vector2.ZERO:
		state_transition.emit(self, "Idle")
	
	# Cambio de estado al empezar a caer
	if parent.velocity.y > 0: state_transition.emit(self, "Fall")
	
	# SWAP DE PISOS
	parent.swap_floors()

	# DISPARA AL HACER CLICK CUANDO TIENE OJOS
	if parent.has_eyes && Input.is_action_just_pressed(parent.actions.shoot): parent.shoot_fireball.emit()
	
func Exit():
	pass
