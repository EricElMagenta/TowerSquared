extends Area2D

signal got_floor

@onready var power_up_screen = $PowerUpScreen

var floor_type = "player_suck_floor"

func _on_body_entered(body):
	if body is Player:
		got_floor.emit(floor_type)

		if !GameManager.screen_suck_floor_saw:
			power_up_screen.init(self, floor_type.erase(0,7))
			power_up_screen.visible = true
			GameManager.screen_suck_floor_saw = true

		else:
			queue_free()
