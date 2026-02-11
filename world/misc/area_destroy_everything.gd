extends Area2D

func _on_body_entered(body):
	if body.has_method("box_destroyed"): 
		body.box_destroyed()

	if body.has_method("platform_destroyed"):
		body.platform_destroyed()

func _on_area_entered(area):
	area.queue_free()
