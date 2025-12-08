extends State
class_name SharkIdle

func Enter():
    pass

func Physics_Update(delta:float):
    parent.player_animations(self.name)

    var direction = parent.move(delta)

    # Cambiar de estado al saltar
    if parent.is_on_floor() && Input.is_action_just_pressed(parent.actions.jump):
        state_transition.emit(self, "SharkedJump")
        
    # Cambiar de estado al caminar
    elif direction != Vector2.ZERO:
        state_transition.emit(self, "SharkedWalk")

    # OCULTA PROMPT PARA HABLAR
    if len(parent.dialogue_area.get_overlapping_areas()) < 1:
        parent.talk_prompt.visible = false
        
    # DETECTA NPC EN EL AREA DEL JUGADOR
    else:
        for area in parent.dialogue_area.get_overlapping_areas():
            # Mostrar signo para hablar
            if area.has_method("talk_to_player"):
                parent.talk_prompt.visible = true
                
                # Habla con el NPC si se oprime el botón
                if Input.is_action_just_pressed(parent.actions.talk):
                    area.talk_to_player()
                    state_transition.emit(self, "SharkedTalk")
                    parent.talking_to = area

            if area.name.to_lower() == "door": 
                parent.talk_prompt.visible = true
                if Input.is_action_just_pressed(parent.actions.talk):
                    parent.enter_door.emit()

            if GameManager.scared_guard && area.name.to_lower() == "secretdoor":
                parent.talk_prompt.visible = true
                if Input.is_action_just_pressed(parent.actions.talk):
                    parent.enter_secret_door.emit()

func Exit():
    pass