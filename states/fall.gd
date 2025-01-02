extends State
class_name Fall

func Enter():
	pass

func Physics_Update(delta:float):
	
	parent.player_animations(self.name)
	
	parent.move(delta)
	
	# Saltar en el aire
	if !parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		if parent.remaining_air_jumps > 0:
			state_transition.emit(self, "AirJump")	
	
	# Cambiar estado al tocar el suelo
	if parent.is_on_floor(): state_transition.emit(self, "Idle")

	# SWAP DE PISOS
	parent.swap_floors()

	# DISPARA AL HACER CLICK CUANDO TIENE OJOS
	if parent.has_eyes && Input.is_action_just_pressed(parent.actions.shoot): parent.shoot_fireball.emit()

func Exit():
	pass
