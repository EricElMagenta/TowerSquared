extends CharacterBody2D

@export var speed:int
@export var dir:int
@export var is_accelerating := false
var damage = 3
var extra_speed = 0


func _ready():
	scale.x = dir
	$AnimatedSprite2D.play("default")

func _physics_process(delta):

	# Cambia de dirección al chocar con paredes
	if is_on_wall() : handle_collisions()

	if is_accelerating: accelerate()

	velocity.x = (speed + extra_speed) * dir

	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func accelerate():
	extra_speed += 0.2

func handle_collisions():
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	dir *= -1

func _on_hitbox_body_entered(body:Node2D):
	if body.has_method("get_hit") && body.player_data.current_health > 0:
		body.get_hit(damage)

	if body.has_method("get_destroyed"):
		body.get_destroyed()
