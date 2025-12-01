extends State
class_name SharkWalk

func Enter():
    pass

func Physics_Update(delta:float):
    parent.player_animations(self.name)

    var direction = parent.move(delta)

    # Cambiar de estado al saltar
    if parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
        state_transition.emit(self, "SharkedJump")

    # Cambiar estado al detenerse
    elif direction == Vector2.ZERO:
        state_transition.emit(self, "SharkedIdle")

    # Cambio de estado al empezar a caer
    if parent.velocity.y > 0: state_transition.emit(self, "SharkedFall")

    # OCULTA PROMPT PARA HABLAR
    if len(parent.dialogue_area.get_overlapping_areas()) < 1:
        parent.talk_prompt.visible = false
        
    # DETECTA NPC EN EL AREA DEL JUGADOR Y MUESTRA PROMPT PARA HABLAR
    else:
        for area in parent.dialogue_area.get_overlapping_areas():
            if area.has_method("talk_to_player"):
                parent.talk_prompt.visible = true
            
            if area.name.to_lower() == "door": 
                parent.talk_prompt.visible = true

func Exit():
    pass