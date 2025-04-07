extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var power_up_screen = $PowerUpScreen

signal got_floor

var floor_type = "player_arm_floor"

func _ready():
	animated_sprite_2d.play("idle")

func _on_body_entered(body):
	if body is Player:
		got_floor.emit(floor_type)
		
		if !GameManager.screen_arm_floor_saw:
			power_up_screen.init(self, floor_type.erase(0,7))
			power_up_screen.visible = true
			GameManager.screen_arm_floor_saw = true
			
		else:
			queue_free()
