extends State
class_name SwimIdle

func Enter():
	pass
	
func Physics_Update(delta:float):
	
	# DISMINUYE EL IMPULSO EN EL AGUA
	if parent.is_on_wall(): parent.player_data.impulse = 0
	parent.player_data.impulse -= 10 * sign(parent.player_data.impulse)
	
	parent.player_animations("Fall")
	
	# MOVERSE EN EL AGUA
	var direction = parent.move_in_water(delta)
	
	if direction != Vector2.ZERO:
		state_transition.emit(self, "SwimMove")

	# NADAR HACIA ARRIBA
	if Input.is_action_pressed(parent.actions.jump): parent.swim_up()
	
	# SALIR DEL AGUA
	if len(parent.dialogue_area.get_overlapping_areas()) == 0:
		state_transition.emit(self, "Idle")
	
	# MORIRSE AL QUEDARSE SIN VIDA
	if parent.player_data.current_health <= 0:
		state_transition.emit(self, "Dead")
	
	###################### HABILIDADES ################################
	# SWAP DE PISOS
	if Input.is_action_just_pressed(parent.actions.swap_up): parent.swap_floors("up")
	if Input.is_action_just_pressed(parent.actions.swap_down): parent.swap_floors("down")
	
	# DISPARA AL HACER CLICK SI TIENE OJOS
	if parent.get_floor_count("eye_floor") && Input.is_action_just_pressed(parent.actions.shoot): parent.shoot_fireball.emit()
	
	# CARGAR PROPULSOR
	if Input.is_action_pressed(parent.actions.action) && parent.get_floor_count("propeller_floor"): state_transition.emit(self, "Charge")
	
func Exit():
	pass
