extends Node2D

# SEÑALES
signal level_finished

# NODOS
@onready var sprite_2d = $Sprite2D


func _on_area_2d_body_entered(body):
	if body is Player && sprite_2d.frame==0:
		level_finished.emit()
