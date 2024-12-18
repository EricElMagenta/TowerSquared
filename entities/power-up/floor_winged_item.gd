extends Area2D


signal got_floor

var floor_type = "winged_floor"

func _on_body_entered(body):
	got_floor.emit(floor_type)
	queue_free()
