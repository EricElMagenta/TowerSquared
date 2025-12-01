extends State
class_name SharkFall

func Enter():
    pass

func Physics_Update(delta:float):
    parent.player_animations(self.name)

    parent.move(delta)

    # Cambiar estado al tocar el suelo
    if parent.is_on_floor(): state_transition.emit(self, "SharkedIdle")

func Exit():
    pass
