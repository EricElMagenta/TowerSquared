extends State
class_name SharkedTalk

func Enter():
	AudioManager.play_dialogue_sound()
	parent.talk_prompt.visible = false

func Update(_delta:float):
	if Input.is_action_just_pressed(parent.actions.stop_talking):
		DialogueManager.end_dialogue()
		state_transition.emit(self, "SharkedIdle")
	
func Exit():
	parent.talk_prompt.visible = true