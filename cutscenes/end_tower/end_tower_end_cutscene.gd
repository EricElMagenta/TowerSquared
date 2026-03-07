extends Node2D

@onready var animation_player = $AnimationPlayer
@export var autoplay : bool = false
# @onready var camera_2d = $Camera2D

func _ready():
	if AudioManager.music.playing: AudioManager.music.stop()
	RenderingServer.set_default_clear_color(Color.BLACK)

func _input(event):
	if event.is_action_pressed("next") && !animation_player.is_playing():
		animation_player.play()

func pause():
	if autoplay == false:
		animation_player.pause()

func take_photo():
	animation_player.play("photo")

func next_anim():
	animation_player.play("end")


func play_sound():
	$SFX.play()

func change_scene():
	get_tree().change_scene_to_file("res://cutscenes/credits.tscn")