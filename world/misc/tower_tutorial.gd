extends Area2D

func go_to_next_zone():
	get_tree().call_deferred("change_scene_to_file", "res://world/tutorial/tutorial_1.tscn")
