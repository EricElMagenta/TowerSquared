extends Node2D

@onready var sfx = $SFX

func play_sound():
	GameManager.sharked_player = false
	AudioManager.music.stop()
	sfx.play()

func go_next_scene():
	get_tree().change_scene_to_file("res://world/tutorial/tutorial_1.tscn")