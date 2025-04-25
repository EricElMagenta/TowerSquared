extends State
class_name SwimIdle

func Enter():
	pass
	
func Physics_Update(delta:float):
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
		
	###################### HABILIDADES ################################
	# SWAP DE PISOS
	if Input.is_action_just_pressed(parent.actions.swap_up): parent.swap_floors("up")
	if Input.is_action_just_pressed(parent.actions.swap_down): parent.swap_floors("down")

func Exit():
	pass
