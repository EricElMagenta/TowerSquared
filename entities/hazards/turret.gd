extends StaticBody2D

#VARIABLES
@export var bullet:PackedScene
var can_shoot = true

# NODOS
@onready var shoot_timer = $ShootTimer

###################################### FUNCIONES PRINCIPALES ###############################
func _physics_process(delta):
	if can_shoot: shoot_bullet()
	
##################################### FUNCIONES AUXILIARES ###############################
func shoot_bullet():
	var bullet_instance = bullet.instantiate()
	bullet_instance.dir = self.scale.x

	add_child(bullet_instance)
	
	can_shoot = false
	shoot_timer.start()

##################################### SEÑALES ###############################
func _on_shoot_timer_timeout():
	can_shoot = true
