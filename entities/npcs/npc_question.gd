extends CharacterBody2D

const lines: Array[String] = [
	"tutorial_question_floor_1",
	"tutorial_question_floor_2"
]

func talk_to_player():
	DialogueManager.start_dialog(global_position, lines)
