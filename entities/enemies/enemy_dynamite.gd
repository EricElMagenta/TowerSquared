extends CharacterBody2D

@export var speed = 50
var dir = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var fall_raycast = $FallRaycast
@onready var hitbox = $Hitbox

func _ready():
	animated_sprite_2d.play("walk")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall() || !fall_raycast.is_colliding(): handle_collisions()
	
	velocity.x = speed * dir
	move_and_slide()

func handle_collisions():
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	dir *= -1
	fall_raycast.position.x *= -1

func get_destroyed():
	speed = 0
	hitbox.set_collision_mask_value(2, false)
	animated_sprite_2d.play("explode")

func _on_area_2d_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit()

func _on_animated_sprite_2d_animation_finished():
	queue_free()
