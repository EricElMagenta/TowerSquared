extends State
class_name AirJump

func Enter():
	# Saltar al iniciar el estado
	parent.air_jump()
	parent.remaining_air_jumps -= 1
	
func Physics_Update(delta:float):
	
	parent.player_animations(self.name)
	
	parent.move(delta)
	
	# Salto en el aire (si es que quedan saltos)
	if !parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		if parent.remaining_air_jumps > 0:
			parent.remaining_air_jumps -= 1
			parent.air_jump()
	
	# Cambio de estado al empezar a caer
	if parent.velocity.y > 0: state_transition.emit(self, "Fall")

	###################### HABILIDADES ################################
	# SWAP DE PISOS
	parent.swap_floors()

	# DISPARA AL HACER CLICK CUANDO TIENE OJOS
	if parent.has_eyes && Input.is_action_just_pressed(parent.actions.shoot): parent.shoot_fireball.emit()
	
	# AGARRAR COSAS
	if parent.has_arms && Input.is_action_just_pressed(parent.actions.action): parent.action.emit()
	
	# SOLTAR COSAS
	if parent.has_arms && Input.is_action_just_pressed(parent.actions.stop_action): parent.stop_action.emit()

func Exit():
	pass
