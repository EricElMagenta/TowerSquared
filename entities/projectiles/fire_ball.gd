extends CharacterBody2D
class_name PlayerProjectile

@export var speed = 400.0

var dir:int
var spawn_pos:Vector2

# Spawnea en las coordenadas introducidas
func _ready():
	global_position = spawn_pos
	$Area2D.rotate(45)

# Viaja hasta chocar con algo, entonces desaparece
func _physics_process(_delta):
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
	
#	SI DISPARA A UN OBJETO AGARRABLE LO DESTRUYE (SI ES POSIBLE) SIEMPRE Y CUANDO NO ESTÉ SIENDO AGARRADO

	if body.is_in_group("grabeable"):
		if !body.grabbed && body.has_method("get_destroyed"):
			body.get_destroyed()
			queue_free()
		
		if !body.grabbed && body.has_method("destroy_bullet"):
			queue_free()
#	DESTRUYE EL OBJETO CON EL CHOCA SIEMPRE Y CUANDO SEA DESTRUIBLE
	else:
		if body.has_method("get_destroyed"): 
			body.get_destroyed()
			queue_free()
