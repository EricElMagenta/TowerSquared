extends Area2D

@export var next_zone : PackedScene

func go_to_next_zone():
	GameManager.player_plaza_position = Vector2(-421, 70)
	get_tree().call_deferred("change_scene_to_packed", next_zone)
