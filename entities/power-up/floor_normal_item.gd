extends Area2D

signal got_floor(floor_type : String)

var floor_type = "normal_floor"

func _on_body_entered(body):
	got_floor.emit("got_floor", floor_type)
	print("dsadsa")
	queue_free()
