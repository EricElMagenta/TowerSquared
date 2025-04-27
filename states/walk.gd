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
	
	# DISMINUYE EL IMPULSO EN TIERRA
	parent.handle_earth_impulse()
	
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
	
	# OCULTA PROMPT PARA HABLAR
	if len(parent.dialogue_area.get_overlapping_areas()) < 1:
		parent.talk_prompt.visible = false
		
	# DETECTA NPC EN EL AREA DEL JUGADOR Y MUESTRA PROMPT PARA HABLAR
	else:
		for area in parent.dialogue_area.get_overlapping_areas():
			if area.has_method("talk_to_player"):
				parent.talk_prompt.visible = true
	
	# MORIRSE AL QUEDARSE SIN VIDA
	if parent.player_data.current_health <= 0:
		state_transition.emit(self, "Dead")

func Exit():
	pass
