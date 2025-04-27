extends State
class_name Charge

func Enter():
	parent.player_data.impulse = 0
	parent.show_charge_bar()

func Physics_Update(delta:float):
	parent.charge_propeller.emit()
	
	parent.player_animations("Fall")
	
	if Input.is_action_just_released(parent.actions.action): state_transition.emit(self, "SwimIdle")
	
func Exit():
	parent.release_propeller.emit()
	parent.delete_charge_bar()
