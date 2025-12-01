extends State
class_name SharkJump

func Enter():
    # Saltar al iniciar el estado
    parent.jump()
    AudioManager.play_jump()

func Physics_Update(delta:float):
    parent.talk_prompt.visible = false
    parent.player_animations(self.name)
    parent.move(delta)

    # Cambio de estado al empezar a caer
    if parent.velocity.y > 0: state_transition.emit(self, "SharkedFall")

func Exit():
    pass
