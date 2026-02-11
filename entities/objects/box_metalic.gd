extends CharacterBody2D

# VARIABLES
var grabbed_by: Floor
var grabbed = false
var spawn_pos:Vector2

# NODOS
@onready var grab_bullet_detect = $GrabBulletDetect
@onready var floor_detect_area = $FloorDetectArea

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	spawn_pos = position

func _physics_process(delta):
	# Se vuelve inmune a los disparos del jugador mientras es agarrado
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

	move_and_slide()

func destroy_bullet(bullet):
	bullet.queue_free()

func box_destroyed():
	queue_free()

func return_to_spawn_point():
	position = spawn_pos