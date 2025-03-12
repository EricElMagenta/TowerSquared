extends Node2D

# SEÑALES
signal button_pressed

# NODOS
@onready var push_area = $PushArea
@onready var sprite_2d = $Sprite2D

func _on_push_area_body_entered(body):
	if body is PlayerProjectile || body is Player:
		button_pressed.emit()
		sprite_2d.frame = 1
