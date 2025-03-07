extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var floor_detect_area = $FloorDetectArea
@onready var grab_bullet_detect = $GrabBulletDetect

#const lerp_speed = 500

var grabbed_by: Floor
var grabbed = false

func _ready():
	animated_sprite_2d.play("idle")
	
func _physics_process(delta):
	if grabbed && grabbed_by:
		set_collision_mask_value(1, false)
		set_collision_mask_value(5, false)
		set_collision_mask_value(6, false)
		set_collision_layer_value(6, false)
		position = grabbed_by.global_position + Vector2(28 * grabbed_by.player.dir, 0)
		
	else:
		set_collision_mask_value(1, true)
		set_collision_mask_value(5, true)
		set_collision_mask_value(6, true)
		set_collision_layer_value(6, true)
		if not is_on_floor(): velocity += get_gravity() * delta
		
	velocity.x *= -0.3
	
#	HITBOX SEPARADA PARA DETECTAR BALAS MIENTRAS EL OBJETO ESTÁ AGARRADO. 
#	NO ES LO IDEAL PORQUE EL CÓDIGO DEBERÍA ESTAR EN LA BALA.
	for body in grab_bullet_detect.get_overlapping_bodies():
		body.queue_free()
		get_destroyed()

	move_and_slide()

#func _integrate_forces(state):
	#if grabbed:
		#var speed = lerp_speed*global_transform.origin.distance_to(grabbed_by.global_transform.origin)
		#var dir = global_transform.origin.direction_to(grabbed_by.global_transform.origin)
		#apply_central_force(dir*speed)
		#
		#set_deferred("freeze", true) 
		#set_deferred("freeze_mode", 1) 
		#
		#gravity_scale = 0
	#else:
		#gravity_scale = 1


func get_destroyed():
	set_collision_mask_value(2, false)
	animated_sprite_2d.play("destroyed")

func _on_animated_sprite_2d_animation_finished():
	call_deferred("queue_free")

func get_grabbed():
	grabbed = true
