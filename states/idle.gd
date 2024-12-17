extends State
class_name Idle

func Enter():
	print("entrado")

func Update(_delta: float):
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis == 1: 
		state_transition.emit(self, "walk")
	
	
func Exit():
	print("saliendes")
