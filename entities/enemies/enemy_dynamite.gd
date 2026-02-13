extends Enemy

# VARIABLES
@export var speed = 100
var dir = 1
var damage = 1

# NODOS
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var fall_raycast = $FallRaycast
@onready var hitbox = $Hitbox


##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	animated_sprite_2d.play("walk")

func _physics_process(delta):
	# Detecta al jugador constantemente
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("get_hit") && body.player_data.current_health > 0:
			body.get_hit(damage)
	
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Cambia de dirección al chocar con paredes
	if is_on_wall() || !fall_raycast.is_colliding(): handle_collisions()
	
	velocity.x = speed * dir
	move_and_slide()

##################################### FUNCIONES AUXILIARES ###############################
	# Cambia de dirección al chocar con paredes
func handle_collisions():
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	dir *= -1
	fall_raycast.position.x *= -1

func get_destroyed():
	speed = 0
	set_collision_layer_value(3, false)
	hitbox.set_collision_mask_value(2, false)
	hitbox.set_collision_mask_value(5, false)
	animated_sprite_2d.play("explode")
	
	AudioManager.play_explosion()
	await get_tree().create_timer(0.4).timeout
	AudioManager.play_box_explode()

func get_eaten():
	get_destroyed()

func _on_animated_sprite_2d_animation_finished():
	queue_free()
