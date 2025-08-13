extends Area2D

############################ FUNCIONES AUXILIARES #############################
func _on_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit(3)

func _on_area_entered(area):
	if area.has_method("get_popped") :
		area.get_popped()
