extends Node2D

# NODOS
@export var next_scene:PackedScene
@export var pause:=false
@onready var animation_player = $AnimationPlayer


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	AudioManager.music.stop()
	animation_player.play("sea_tower_intro_1")

func next_animation_1():
	animation_player.play("sea_tower_intro_2")

func play_sound():
	$Sound.play()

func change_scene():
	get_tree().change_scene_to_packed(next_scene)
