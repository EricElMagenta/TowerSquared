extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_detect_area = $PlayerDetectArea
@export var speed = 200.0

var dir:int
var spawn_pos:Vector2

func _ready():
	global_position = spawn_pos
	animated_sprite_2d.play("default")

func _physics_process(_delta):
	velocity = Vector2(speed * dir, 0)
	move_and_slide()
	
	if is_on_wall(): wall_collision_detected()

func wall_collision_detected():
	dir *= -1
	#scale.x *= -1

func explode():
	speed = 0
	AudioManager.play_explosion()
	set_collision_mask_value(1,false)
	set_collision_layer_value(1,false)
	animated_sprite_2d.play("explode")


func platform_destroyed():
	explode()

func _on_player_detect_area_body_entered(body:Node2D):
	if body is Player || body.is_in_group("grabeable"): explode()

func _on_animated_sprite_2d_animation_finished():
	queue_free()