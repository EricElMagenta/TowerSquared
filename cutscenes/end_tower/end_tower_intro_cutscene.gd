extends Node2D


func _ready():
	GameManager.sharked_player = false
	AudioManager.music.stop()
	RenderingServer.set_default_clear_color(Color.BLACK)

func play_sound():
	$SFX.play()

func go_next_scene():
	get_tree().change_scene_to_file("res://world/end_tower/end_tower_1.tscn")