extends CharacterBody2D

const lines: Array[String] = [
	"question_floor_greet"
]

func talk_to_player():
	DialogueManager.start_dialog(global_position, lines)
