extends Enemy

@export var speed = 70
var dir = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox

func _ready():
	animated_sprite_2d.play("fly")

func _physics_process(delta):
	if is_on_wall(): handle_collisions()
	velocity.x = dir * speed
	move_and_slide()

func handle_collisions():
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	dir *= -1
	
func get_destroyed():
	speed = 0
	hitbox.set_collision_mask_value(2, false)
	animated_sprite_2d.play("explode")

func _on_animated_sprite_2d_animation_finished():
	queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit()
