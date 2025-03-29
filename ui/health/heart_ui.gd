extends Panel

@onready var sprite_2d = $Sprite2D

# Cambia los cuadritos según la vida del jugador
func update(full:bool):
	if full: sprite_2d.frame = 0
	else: sprite_2d.frame = 1
