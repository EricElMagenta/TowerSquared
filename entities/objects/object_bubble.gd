extends Area2D
class_name Bubble

@export var bounce_multiplier : int
var spawn_pos : Vector2


func _ready():
	global_position = spawn_pos
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	position.y -= 1
	position.x = sin(Time.get_ticks_msec()*delta*0.5)

func make_player_bounce() -> float:
	return bounce_multiplier
