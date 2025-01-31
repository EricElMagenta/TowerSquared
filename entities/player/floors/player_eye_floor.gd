extends Floor

@onready var sprite_2d = $Sprite2D

@export var fireball:PackedScene

var can_shoot = true

func _ready():
	player.change_direction.connect(change_direction)
	player.shoot_fireball.connect(shoot_fireball)
	
func change_direction():
	sprite_2d.flip_h = (player.input_vector.x < 0)

func shoot_fireball():
	var fireball_instance = fireball.instantiate()
	fireball_instance.dir = player.dir
	
	if fireball_instance.dir == 1: fireball_instance.spawm_pos = global_position + Vector2(25, 0)
	elif fireball_instance.dir == -1: fireball_instance.spawm_pos = global_position + Vector2(-25, 0)
	
	if can_shoot: 
		get_tree().root.add_child(fireball_instance)
		can_shoot = false

func _on_reload_timer_timeout():
	can_shoot = true
