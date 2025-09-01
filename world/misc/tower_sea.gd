extends Area2D

func go_to_next_zone():
	get_tree().call_deferred("change_scene_to_file", "res://cutscenes/sea_tower/sea_tower_intro_cutscene_1.tscn")
