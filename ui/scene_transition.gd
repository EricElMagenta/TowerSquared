extends CanvasLayer

signal on_transition_finished

@onready var animation_player = $AnimationPlayer

func next_level_transition():
	animation_player.play("next_level_transition")
	#await get_tree().create_timer(0.5).timeout
	#animation_player.play_backwards("transition")

func new_level_transition():
	animation_player.play("new_level_transition")
