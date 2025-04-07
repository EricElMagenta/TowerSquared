extends State
class_name Idle

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
		
	# Cambiar de estado al caminar
	elif direction != Vector2.ZERO:
		state_transition.emit(self, "Walk")
	
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
	
	
	# OCULTA PROMPT PARA HABLAR
	if len(parent.dialogue_area.get_overlapping_bodies()) < 1:
		parent.talk_prompt.visible = false
		
	# DETECTA NPC EN EL AREA DEL JUGADOR
	else:
		for body in parent.dialogue_area.get_overlapping_bodies():
			
			# Mostrar signo para hablar
			if body.has_method("talk_to_player"):
				parent.talk_prompt.visible = true
				
				# Habla con el NPC si se oprime el botón
				if Input.is_action_just_pressed(parent.actions.up):
					body.talk_to_player()
					state_transition.emit(self, "Talking")
					parent.talking_to = body

func Exit():
	pass
