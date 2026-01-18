extends Node2D

@export var next_scene:PackedScene
@export var pause:=false
@onready var animation_player = $AnimationPlayer

func _ready():
	GameManager.sharked_player = false
	RenderingServer.set_default_clear_color(Color.BLACK)
	AudioManager.music.stop()
	animation_player.play("techno_tower_intro")

func play_sound():
	$Sound.play()

func change_scene():
	get_tree().change_scene_to_packed(next_scene)
