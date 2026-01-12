extends Path2D
class_name MovingPlatform

# NODOS
@onready var animated_sprite_2d = $AnimatableBody2D/AnimatedSprite2D
@onready var path_follow = $PathFollow2D

# VARIABLES
@export var speed = 100
@export var is_looping := false
@export var auto_start := false
var moving := false

func _ready():
	if auto_start: moving = true
	path_follow.loop = is_looping
	animated_sprite_2d.play("stop")

func _physics_process(delta):
	if moving: start_moving(delta)
	
	if path_follow.progress_ratio == 1:
		if !is_looping: stop_moving()

func start_moving(delta):
	animated_sprite_2d.play("move")
	path_follow.progress += speed * delta

func stop_moving():
	moving = false
	animated_sprite_2d.play("stop")

func _on_area_2d_body_entered(body:Node2D):
	if body is Player: moving = true
