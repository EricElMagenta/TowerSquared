extends Node2D

func _ready():
    RenderingServer.set_default_clear_color(Color.BLACK)

func go_next_scene():
    get_tree().change_scene_to_file("res://cutscenes/tutorial_tower/tutorial_intro_cutscene.tscn")