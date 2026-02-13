extends Enemy

enum MOVEMENT{
	STILL,
	HORIZONTAL,
	HORIZONTAL_WALL_TURN,
	VERTICAL
}

@export var selected_movement = MOVEMENT.STILL
@export var limit_left := -100
@export var limit_right := 100
@export var limit_up := 100
@export var limit_down := -100
@export var speed := 1.0

var initial_pos : Vector2
var dir = 1
var damage = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	animated_sprite_2d.play("fly")
	initial_pos = position

func _physics_process(_delta):
	
	match selected_movement:
		MOVEMENT.STILL:
			position = initial_pos
			
		MOVEMENT.HORIZONTAL: 
			if initial_pos.x - position.x < (limit_right*-1) || initial_pos.x - position.x > (limit_left*-1) || is_on_wall(): 
				animated_sprite_2d.scale.x *= -1
				dir *= -1
				
			position.x += dir * speed
		
		MOVEMENT.VERTICAL: 
			if initial_pos.y - position.y > limit_up || initial_pos.y - position.y < limit_down || is_on_floor() || is_on_ceiling(): 
				dir *= -1
			position.y += dir * speed
			
		MOVEMENT.HORIZONTAL_WALL_TURN:
			
			# Detecta al jugador constantemente
			for body in hitbox.get_overlapping_bodies():
				if body.has_method("get_hit") && body.player_data.current_health > 0:
					body.get_hit(damage)
			
			# Cambia de dirección al chocar con paredes
			if is_on_wall(): handle_collisions()
		
	move_and_slide()
	
##################################### FUNCIONES AUXILIARES ###############################
	# Cambia de dirección al chocar con paredes
func handle_collisions():
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	dir *= -1
	
func get_destroyed():
	speed = 0
	set_collision_layer_value(3, false)
	hitbox.set_collision_mask_value(2, false)
	AudioManager.play_explosion()
	animated_sprite_2d.play("explode")
	
	AudioManager.play_explosion()
	await get_tree().create_timer(0.4).timeout
	AudioManager.play_box_explode()

func get_eaten():
	get_destroyed()

func _on_animated_sprite_2d_animation_finished():
	queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit(damage)
