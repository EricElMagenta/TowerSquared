extends StaticBody2D

@export var wall_id:int
@export var buttons_required:int = 1

func lower_buttons_required():
	buttons_required -= 1
	if buttons_required <= 0:
		queue_free()