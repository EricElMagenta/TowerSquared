extends Node2D


@onready var animation_player = $AnimationPlayer
@export var autoplay : bool = false

func _ready(): AudioManager.change_song("credits")

func _input(event):
	if event.is_action_pressed("next") && !animation_player.is_playing():
		animation_player.play()

func pause():
	if autoplay == false:
		animation_player.pause()

func back_to_game():
	get_tree().change_scene_to_file("res://world/misc/world_map.tscn")