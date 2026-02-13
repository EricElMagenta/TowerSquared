extends CharacterBody2D
class_name Train

@onready var player_detect_area =  $PlayerDetect

@export var speed:int
@export var dir:int
@export var is_accelerating := false
@export var is_super_accelerating := false
@export var is_super_duper_accelerating := false
@export var is_waiting := false
var damage = 3
var extra_speed = 0


func _ready():
	scale.x = dir
	$AnimatedSprite2D.play("default")

func _physics_process(delta):

	# Cambia de dirección al chocar con paredes
	if is_on_wall() : handle_collisions()

	if !is_waiting: 
		if is_accelerating: accelerate()
		elif is_super_accelerating: super_accelerate()
		elif is_super_duper_accelerating: super_duper_accelerate()

	velocity.x = (speed + extra_speed) * dir

	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func accelerate():
	extra_speed += 0.2

func super_accelerate(): 
	extra_speed += 0.4

func super_duper_accelerate():
	extra_speed += 0.6

func handle_collisions():
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	dir *= -1

func _on_hitbox_body_entered(body:Node2D):
	if body.has_method("get_hit") && body.player_data.current_health > 0:
		body.get_hit(damage)

	if body.has_method("get_destroyed"):
		body.get_destroyed()


func _on_player_detect_body_entered(body:Node2D):
	if body is Player: is_waiting = false
