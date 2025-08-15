extends Area2D

func talk_to_player():
	DialogueManager.start_dialog(global_position, [get_parent().dialogue])
