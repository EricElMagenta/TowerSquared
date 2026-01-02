extends Area2D

signal got_floor

var floor_type = "player_granade_launcher_floor"

func _on_body_entered(body:Node2D):
	if body is Player:
		got_floor.emit(floor_type)
		queue_free()
