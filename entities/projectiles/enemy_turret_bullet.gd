extends EnemyProjectile

# NODOS
@onready var hitbox = $Hitbox

# VARIABLES
var damage = 1
var dir = 1
const SPEED = 300


##################################### FUNCIONES PRINCIPALES ###############################
func _physics_process(delta):
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("get_hit"):
			body.get_hit(damage)
		
		
	velocity.x = SPEED * dir
	move_and_slide()

	#if is_on_wall():
		#queue_free()
		
func get_eaten():
	queue_free()

##################################### FUNCIONES AUXILIARES ###############################
func _on_hitbox_body_entered(body):
	if body.has_method("get_destroyed"):
		body.get_destroyed()
		queue_free()
