extends CharacterBody2D

# CONSTANTES
const RECOVER_SPEED = 100

# NODOS
@export var bullet:PackedScene
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_detect_area = $PlayerDetectArea
@onready var fall_raycast = $FallRaycast
@onready var hitbox = $Hitbox

# VARIABLES
@export var speed = 100
@export var dir = 1
var damage = 1


##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	animated_sprite_2d.play("walking")

func _physics_process(delta):
	# Detecta al jugador constantemente
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("get_hit") && body.player_data.current_health > 0:
			body.get_hit(damage)

	# Add the gravity
	if not is_on_floor() && animated_sprite_2d.animation != "explode":
		velocity += get_gravity() * delta
	
	# Cambia de dirección al chocar con paredes
	if is_on_wall() || !fall_raycast.is_colliding(): handle_collisions()
	
	velocity.x = speed * dir
	move_and_slide()

func handle_collisions():
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	dir *= -1
	fall_raycast.position.x *= -1
	player_detect_area.position.x *= -1

func get_destroyed():
	player_detect_area.monitoring = false
	speed = 0
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	hitbox.set_collision_mask_value(2, false)
	hitbox.set_collision_mask_value(5, false)
	animated_sprite_2d.play("explode")
	
	AudioManager.play_explosion()
	await get_tree().create_timer(0.4).timeout
	AudioManager.play_box_explode()

func prepare_to_shoot():
	speed = 0
	animated_sprite_2d.play("shooting")


func shoot():
	var bullet_instance = bullet.instantiate()
	bullet_instance.dir = dir
	
	if bullet_instance.dir == 1: bullet_instance.position = global_position + Vector2(15, 0)
	elif bullet_instance.dir == -1: bullet_instance.position = global_position + Vector2(-15, 0)
	
	AudioManager.play_shoot()
	
	add_sibling(bullet_instance)

##################################### SEÑALES #########################################
func _on_player_detect_area_body_entered(body:Node2D):
	if body is Player:
		prepare_to_shoot()


func _on_animated_sprite_2d_animation_finished():
	match animated_sprite_2d.animation:
		"shooting": 
			animated_sprite_2d.play("walking")
			speed = RECOVER_SPEED

		"explode": queue_free()


func _on_animated_sprite_2d_frame_changed():
	match animated_sprite_2d.animation:
		"shooting": if animated_sprite_2d. frame == 1: shoot()
