extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const lines: Array[String] = [
	"suspicious_floor_greet"
]

func _ready():
	animated_sprite_2d.play("idle") 

func talk_to_player():
	DialogueManager.start_dialog(global_position, lines)
