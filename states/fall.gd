extends State
class_name Fall

func Enter():
	pass

func Physics_Update(delta:float):
	
	parent.player_animations(self.name)
	
	parent.move(delta)
	
	# Saltar en el aire
	if !parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		if parent.floor_manager.remaining_air_jumps > 0:
			state_transition.emit(self, "AirJump")	
	
	# Cambiar estado al tocar el suelo
	if parent.is_on_floor(): state_transition.emit(self, "Idle")

	###################### HABILIDADES ################################
	# SWAP DE PISOS
	if Input.is_action_just_pressed(parent.actions.swap_up): parent.swap_floors("up")
	if Input.is_action_just_pressed(parent.actions.swap_down): parent.swap_floors("down")

	# DISPARA AL HACER CLICK SI TIENE OJOS
	if parent.get_floor_count("eye_floor") && Input.is_action_just_pressed(parent.actions.shoot): parent.shoot_fireball.emit()
	
	# AGARRAR COSAS SI TIENE BRAZOS
	if parent.get_floor_count("arm_floor") && Input.is_action_just_pressed(parent.actions.action): parent.action.emit()
	
	# SOLTAR COSAS SI TIENE BRAZOS
	if parent.get_floor_count("arm_floor") && Input.is_action_just_pressed(parent.actions.stop_action): parent.stop_action.emit()
	
	# SUCKEAR BURBUJAS
	if parent.get_floor_count("suck_floor") && Input.is_action_just_pressed(parent.actions.action): parent.action.emit()
	
	# DESSUCKEAR BURBUJAS
	if parent.get_floor_count("suck_floor") && Input.is_action_just_pressed(parent.actions.stop_action): parent.stop_action.emit()	
	
	# MORIRSE AL QUEDARSE SIN VIDA
	if parent.player_data.current_health <= 0:
		state_transition.emit(self, "Dead")
	
	# NADA AL CAER EN AGUA SI TIENE LA COLA DE PEZ
	if parent.get_floor_count("fish_floor"):
		for area in parent.dialogue_area.get_overlapping_areas():
			if area is Water: 
				AudioManager.play_water_splash()
				state_transition.emit(self, "SwimIdle")

func Exit():
	pass
