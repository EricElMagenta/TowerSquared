extends Area2D

############################ FUNCIONES AUXILIARES #############################
func _on_body_entered(body):
	if body.has_method("enter_dead_zone"):
		body.enter_dead_zone()

	if body.has_method("return_to_spawn_point"):
		body.return_to_spawn_point()

func _on_area_entered(area):
	if area.has_method("get_popped") :
		area.get_popped()
