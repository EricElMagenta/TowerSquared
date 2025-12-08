extends State
class_name AirJump

func Enter():
	# Saltar al iniciar el estado
	AudioManager.play_jump()
	parent.air_jump()
	parent.floor_manager.remaining_air_jumps -= 1
	
func Physics_Update(delta:float):
	
	parent.player_animations(self.name)
	
	parent.move(delta)
	
	# Salto en el aire (si es que quedan saltos)
	if !parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		if parent.floor_manager.remaining_air_jumps > 0:
			parent.floor_manager.remaining_air_jumps -= 1
			parent.air_jump()
	
	# Cambio de estado al empezar a caer
	if parent.velocity.y > 0: state_transition.emit(self, "Fall")

	###################### HABILIDADES ################################
	# SWAP DE PISOS
	if Input.is_action_just_pressed(parent.actions.swap_up) && parent.floor_manager.get_total_floors() > 1: parent.swap_floors("up")
	if Input.is_action_just_pressed(parent.actions.swap_down) && parent.floor_manager.get_total_floors() > 1: parent.swap_floors("down")

	# DISPARA AL HACER CLICK SI TIENE OJOS
	if parent.get_floor_count("eye_floor") && Input.is_action_just_pressed(parent.actions.shoot): parent.shoot_fireball.emit()
	
	# AGARRAR COSAS SI TIENE BRAZOS
	if parent.get_floor_count("arm_floor") && Input.is_action_just_pressed(parent.actions.action): parent.action.emit()
	
	# SOLTAR COSAS SI TIENE BRAZOS
	if parent.get_floor_count("arm_floor") && Input.is_action_just_pressed(parent.actions.stop_action): parent.stop_action.emit()

	# MORIRSE AL QUEDARSE SIN VIDA
	if parent.player_data.current_health <= 0:
		state_transition.emit(self, "Dead")

	# NADA AL CAER EN AGUA SI TIENE LA COLA DE PEZ
	if parent.get_floor_count("fish_floor"):
		for area in parent.dialogue_area.get_overlapping_areas():
			if area is Water: 
				parent.velocity.y *= .1
				AudioManager.play_water_splash()
				state_transition.emit(self, "SwimIdle")

func Exit():
	pass
