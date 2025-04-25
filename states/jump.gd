extends State
class_name Jump

func Enter():
	# Saltar al iniciar el estado
	parent.jump()
	AudioManager.play_jump()

func Physics_Update(delta:float):
	
	parent.talk_prompt.visible = false
	parent.player_animations(self.name)
	
	parent.move(delta)
	
	# Saltar en el aire
	if !parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		if parent.remaining_air_jumps > 0:
			state_transition.emit(self, "AirJump")
	
	# Cambio de estado al empezar a caer
	if parent.velocity.y > 0: state_transition.emit(self, "Fall")

	###################### HABILIDADES ################################
	# SWAP DE PISOS
	if Input.is_action_just_pressed(parent.actions.swap_up): parent.swap_floors("up")
	if Input.is_action_just_pressed(parent.actions.swap_down): parent.swap_floors("down")

	# DISPARA AL HACER CLICK CUANDO TIENE OJOS
	if parent.has_eyes && Input.is_action_just_pressed(parent.actions.shoot): parent.shoot_fireball.emit()
	
	# AGARRAR COSAS
	if parent.has_arms && Input.is_action_just_pressed(parent.actions.action): parent.action.emit()
	
	# SOLTAR COSAS
	if parent.has_arms && Input.is_action_just_pressed(parent.actions.stop_action): parent.stop_action.emit()

	# MORIRSE AL QUEDARSE SIN VIDA
	if parent.player_data.current_health <= 0:
		state_transition.emit(self, "Dead")
	
	if parent.can_swim:
		for area in parent.dialogue_area.get_overlapping_areas():
			if area is Water: state_transition.emit(self, "SwimIdle")

func Exit():
	pass
