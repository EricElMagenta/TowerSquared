extends Node2D

# SEÑALES
signal button_pressed
signal kill_wall

# ENUMS
enum VICTIM{
	DOOR,
	WALL
}
@export var selected_victim := VICTIM.DOOR

# NODOS
@onready var push_area = $PushArea
@onready var sprite_2d = $Sprite2D

func _on_push_area_body_entered(body):
	if body is PlayerProjectile || body is Player:
		AudioManager.play_button_press()
		sprite_2d.frame = 1
		match selected_victim:
			VICTIM.DOOR: button_pressed.emit()
			VICTIM.WALL: kill_wall.emit()
