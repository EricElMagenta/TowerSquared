extends Node2D


var shake_strength := 0.0
var decay_rate := 5.0

func _ready():
	GameManager.sharked_player = false
	AudioManager.music.stop()
	RenderingServer.set_default_clear_color(Color.BLACK)

func _process(delta):
	shake_strength = lerp(shake_strength, 0.0, decay_rate * delta)
	$Camera2D.offset = shake()

func play_sound():
	$SFX.play()

func go_next_scene():
	get_tree().change_scene_to_file("res://world/air_tower/air_tower_1.tscn")

func apply_shake():
	shake_strength = 10

func shake():
	return Vector2(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength)
	)