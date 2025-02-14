extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

signal got_floor

var floor_type = "player_winged_floor"

func _ready():
	animated_sprite_2d.play("idle")

func _on_body_entered(body):
	if body is Player:
		got_floor.emit(floor_type)
		queue_free()
