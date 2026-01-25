extends CharacterBody2D

const FALLING_SPEED = 300.0
var damage := 1
var touched_floor := 0

func _physics_process(_delta):
	velocity.y = FALLING_SPEED
	if is_on_floor(): 
		if !touched_floor: AudioManager.play_explosion()

		explode()

	move_and_slide()


func explode():
	touched_floor = 1
	$AnimatedSprite2D.play("explode")
	$Hitbox.set_collision_mask_value(2, false)

func _on_hitbox_body_entered(body:Node2D):
	if body.has_method("get_hit"): body.get_hit(damage)

func _on_animated_sprite_2d_animation_finished():
	queue_free()