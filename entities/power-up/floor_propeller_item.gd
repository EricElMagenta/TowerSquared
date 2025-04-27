extends Area2D

signal got_floor

var floor_type = "player_propeller_floor"

func _ready():
	$AnimatedSprite2D.play("charge")

func _on_body_entered(body):
	if body is Player:
		got_floor.emit(floor_type)
		queue_free()
		
