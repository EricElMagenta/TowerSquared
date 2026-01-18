extends Node2D

@onready var animation_player = $AnimationPlayer
@export var next_scene : PackedScene
@export var autoplay : bool = false
@onready var camera_2d = $Camera2D

var shake_strength := 0.0
var decay_rate := 5.0

func _ready():
	if AudioManager.music.playing: AudioManager.music.stop()
	RenderingServer.set_default_clear_color(Color.BLACK)

func _process(delta):
	shake_strength = lerp(shake_strength, 0.0, decay_rate * delta)
	camera_2d.offset = shake()

func _input(event):
	if event.is_action_pressed("next") && !animation_player.is_playing():
		animation_player.play()

func pause():
	if autoplay == false:
		animation_player.pause()

func take_photo():
	animation_player.play("techno_tower_end_photo")

func next_anim():
	animation_player.play("end")

func apply_shake():
	shake_strength = 10

func shake():
	return Vector2(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength)
	)

func play_sound():
	$Sound.play()

func change_scene():
	get_tree().change_scene_to_packed(next_scene)