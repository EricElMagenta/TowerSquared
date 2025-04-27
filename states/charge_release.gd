extends State
class_name ChargeRelease

func Enter():
	pass
	#parent.player_data.impulse = 0

func Physics_Update(delta:float):
	parent.player_animations("Fall")
	parent.player_data.impulse -= 10 * sign(parent.player_data.impulse)

	
	
	# MOVERSE EN EL AGUA
	var direction = parent.move_in_water(delta)
	
	if parent.player_data.impulse > -700 && parent.player_data.impulse < 700:
		state_transition.emit(self, "SwimIdle")
	
func Exit():
	pass
