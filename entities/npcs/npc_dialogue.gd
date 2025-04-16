extends Area2D

func talk_to_player():
	DialogueManager.start_dialog(global_position, [$NpcDialogue.text])

func _ready():
	$AnimatedSprite2D.play("default")
