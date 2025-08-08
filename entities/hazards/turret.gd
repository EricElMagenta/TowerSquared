extends StaticBody2D

#VARIABLES
@export var bullet:PackedScene
@export var shoot_frequency := 1.5
var can_shoot = true

# NODOS
@onready var shoot_timer = $ShootTimer

###################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	shoot_timer.wait_time = shoot_frequency

func _physics_process(_delta):
	if can_shoot: 
		AudioManager.play_bullet_shot()
		shoot_bullet()
	
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
