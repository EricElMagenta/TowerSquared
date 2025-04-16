extends Node2D

@onready var animation_player = $AnimationPlayer
@export var next_scene : PackedScene
@export var autoplay : bool = false

func _input(event):
	if event.is_action_pressed("next") && !animation_player.is_playing():
		animation_player.play()

# PAUSA LA CINEMÁTICA
func pause():
	if autoplay == false:
		animation_player.pause()

func change_scene():
	get_tree().change_scene_to_packed(next_scene)

func play_sound():
	$Sound.play()
