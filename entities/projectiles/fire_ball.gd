extends CharacterBody2D

@export var speed = 400.0

var dir:int
var spawm_pos:Vector2

# Spawnea en las coordenadas introducidas
func _ready():
	global_position = spawm_pos

# Viaja hasta chocar con algo, entonces desaparece
func _physics_process(delta):
	velocity = Vector2(speed * dir, 0)
	move_and_slide()
	
	# Detectar paredes
	if is_on_wall(): collision_detected()

# Desaparece si se acaba el Timer
func _on_timer_timeout():
	queue_free()
	
# Desaparece si choca con algo
func collision_detected():
	queue_free()
	
func _on_area_2d_body_entered(body):
	if body.has_method("box_destroyed"):
		body.box_destroyed()
		queue_free()
