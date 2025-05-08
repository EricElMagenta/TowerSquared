extends State
class_name Idle

func Enter():
	pass

func Physics_Update(delta:float):
	parent.floor_manager.remaining_air_jumps = parent.floor_manager.max_air_jumps
	
	parent.player_animations(self.name)
	
	# Obtener los inputs para moverse
	var direction = parent.move(delta)
	
	# Cambiar de estado al saltar
	if parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
		state_transition.emit(self, "Jump")
		
	# Cambiar de estado al caminar
	elif direction != Vector2.ZERO:
		state_transition.emit(self, "Walk")
	
	# Cambio de estado al empezar a caer
	if parent.velocity.y > 0: state_transition.emit(self, "Fall")
	
	# DISMINUYE EL IMPULSO EN TIERRA
	parent.handle_earth_impulse()
	
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
	
	
	# OCULTA PROMPT PARA HABLAR
	if len(parent.dialogue_area.get_overlapping_areas()) < 1:
		parent.talk_prompt.visible = false
		
	# DETECTA NPC EN EL AREA DEL JUGADOR
	else:
		for area in parent.dialogue_area.get_overlapping_areas():
			
			# Mostrar signo para hablar
			if area.has_method("talk_to_player"):
				parent.talk_prompt.visible = true
				
				# Habla con el NPC si se oprime el botón
				if Input.is_action_just_pressed(parent.actions.up):
					area.talk_to_player()
					state_transition.emit(self, "Talking")
					parent.talking_to = area
	
	# MORIRSE AL QUEDARSE SIN VIDA
	if parent.player_data.current_health <= 0:
		state_transition.emit(self, "Dead")

func Exit():
	pass
