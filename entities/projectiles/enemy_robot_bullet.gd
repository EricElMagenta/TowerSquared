extends CharacterBody2D

# NODOS
@onready var hitbox = $Hitbox

# VARIABLES
var damage = 1
var dir = 1
const SPEED = 300

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	scale.x = dir

func _physics_process(_delta):
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("get_hit") && body.player_data.current_health > 0:
			body.get_hit(damage)
			
	velocity.x = SPEED * dir
	move_and_slide()
	
##################################### FUNCIONES AUXILIARES ###############################
func get_eaten():
	queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("get_destroyed"):
		body.get_destroyed()
		queue_free()
