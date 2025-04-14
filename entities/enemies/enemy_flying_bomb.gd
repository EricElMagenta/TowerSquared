extends Enemy

@export var speed = 70
var dir = 1
var damage = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	animated_sprite_2d.play("fly")

func _physics_process(_delta):
	# Detecta al jugador constantemente
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("get_hit") && body.player_data.current_health > 0:
			body.get_hit(damage)
	
	# Cambia de dirección al chocar con paredes
	if is_on_wall(): handle_collisions()
	
	velocity.x = dir * speed
	move_and_slide()
	
##################################### FUNCIONES AUXILIARES ###############################
	# Cambia de dirección al chocar con paredes
func handle_collisions():
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	dir *= -1
	
func get_destroyed():
	speed = 0
	hitbox.set_collision_mask_value(2, false)
	AudioManager.play_explosion()
	animated_sprite_2d.play("explode")
	
	AudioManager.play_explosion()
	await get_tree().create_timer(0.4).timeout
	AudioManager.play_box_explode()

func _on_animated_sprite_2d_animation_finished():
	queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit(damage)
