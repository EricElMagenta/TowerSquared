extends Node2D

@export var pause:=false
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	if !AudioManager.music.playing || AudioManager.current_music.to_lower() != "secret_level_end": AudioManager.change_song("secret_level_end")

func change_scene():
	get_tree().change_scene_to_file("res://world/misc/floor_bar.tscn")
