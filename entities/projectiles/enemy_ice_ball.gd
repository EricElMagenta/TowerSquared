extends CharacterBody2D

const AMPLIFY_BOUNCE = 300

var dir:int
var spawn_pos:Vector2
var speed = 100
var damage = 1

func _ready():
	global_position = spawn_pos

func _physics_process(delta):
	velocity.x = speed * dir
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor(): bounce()

	if is_on_wall(): explode()

	move_and_slide()

func bounce():
	AudioManager.play_grab_object()
	velocity.y = AMPLIFY_BOUNCE  * -1

func explode():
	set_collision_mask_value(1, false)
	$Hitbox.set_collision_mask_value(2, false)
	speed = 0
	$AnimatedSprite2D.play("explode")


func _on_timer_timeout():
	explode()


func _on_area_2d_body_entered(body:Node2D):
	if body.has_method("get_hit"):
		body.get_hit(damage)
		explode()


func _on_animated_sprite_2d_animation_finished():
	queue_free()
