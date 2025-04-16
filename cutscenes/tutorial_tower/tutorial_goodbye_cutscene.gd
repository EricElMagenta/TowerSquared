extends Node2D

@onready var camera = $Camera2D
@onready var animation_player = $AnimationPlayer
@export var next_scene : PackedScene
@export var autoplay : bool = false

var shake_strength := 0.0
var decay_rate := 5.0

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)

func _process(delta):
	shake_strength = lerp(shake_strength, 0.0, decay_rate * delta)
	camera.offset = shake()

# CONTINÚA LA CINEMÁTICA SI SE OPRIME "NEXT" Y ESTÁ PAUSADO
func _input(event):
	if event.is_action_pressed("next") && !animation_player.is_playing():
		animation_player.play()

# PAUSA LA CINEMÁTICA
func pause():
	if autoplay == false:
		animation_player.pause()

func apply_shake():
	shake_strength = 10

func shake():
	return Vector2(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength)
	)

func change_scene():
	get_tree().change_scene_to_packed(next_scene)

func play_sound():
	$Sound.play()
