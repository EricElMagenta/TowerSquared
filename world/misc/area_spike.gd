extends Area2D

func _on_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit(3)
