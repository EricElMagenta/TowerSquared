extends CharacterBody2D

# NODOS
@onready var hitbox = $Hitbox
@onready var animated_sprite_2d = $AnimatedSprite2D

# VARIABLES
var damage = 1
var dir = 1
var speed = 300

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	scale.x = dir
	animated_sprite_2d.play("bullet")

func _physics_process(_delta):
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("get_hit") && body.player_data.current_health > 0:
			body.get_hit(damage)
			
	velocity.x = speed * dir
	move_and_slide()

func explode():
	speed = 0
	hitbox.set_collision_mask_value(2, false)
	animated_sprite_2d.play("explode")
	AudioManager.play_explosion()

func get_eaten():
	queue_free()

##################################### SEÑALES ###############################
func _on_hitbox_body_entered(body):
	if body.has_method("get_destroyed"):
		body.get_destroyed()

func _on_animated_sprite_2d_animation_finished():
	queue_free()

func _on_timer_timeout():
	explode()
