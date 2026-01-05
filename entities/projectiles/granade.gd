extends CharacterBody2D
class_name Granade

@onready var animated_sprite_2d = $AnimatedSprite2D

# CONSTANTES
const AMPLIFY_BOUNCE = 50

# VARIABLES
@onready var speed = 100.0 
var dir:int
var spawn_pos:Vector2
var spawn_time:float
var air_time:float
var ground_time:float
var ground_touched := false
var floor_index:int
var has_exploded := false

# FUNCIONES
func _ready():
	spawn_time = Time.get_unix_time_from_system()
	global_position = spawn_pos
	$AnimatedSprite2D.play("rolling")

func _physics_process(delta):
	velocity.x = speed * dir
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		if !ground_touched: air_time = save_ground_time()
		granade_bounce()

	if is_on_wall() && !has_exploded: 
		explode()

	move_and_slide()

func save_ground_time():
	ground_time = Time.get_unix_time_from_system()
	ground_touched = true
	return ground_time - spawn_time
 
func granade_bounce():
	AudioManager.play_grab_object()
	velocity.y = ((floor_index  + 1) * (AMPLIFY_BOUNCE * (air_time + 1)))  * -1


func _on_area_2d_body_entered(body:Node2D):
	explode()
	if body.has_method("get_destroyed"):
		body.get_destroyed()


func explode():
	has_exploded = true
	speed = 0
	AudioManager.play_box_explode()
	animated_sprite_2d.play("explode")


func _on_animated_sprite_2d_animation_finished():
	queue_free()
