extends EnemyProjectile

@onready var hitbox = $Hitbox

const SPEED = 300

func _physics_process(delta):
	velocity.x = SPEED
	move_and_slide()

func _on_hitbox_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit()
		
	if body.has_method("get_destroyed"):
		body.get_destroyed()
		queue_free()

func get_eaten():
	queue_free()
