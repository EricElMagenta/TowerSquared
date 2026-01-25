extends AnimatedSprite2D

@export var ice_ball:PackedScene 
@onready var marker_2d = $Marker2D
var dir:int


func _ready():
	play("left")
	dir = -1

func shoot_ice_ball():
	var ice_ball_instance = ice_ball.instantiate()
	ice_ball_instance.spawn_pos = marker_2d.global_position
	ice_ball_instance.dir = dir
	add_sibling(ice_ball_instance)


func _on_left_body_entered(_body:Node2D):
	dir = -1
	play("left")

func _on_right_body_entered(_body:Node2D):
	dir = 1
	play("right")


func _on_ice_ball_timer_timeout():
	shoot_ice_ball()
