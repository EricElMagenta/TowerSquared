extends Floor

#VARIABLES
@export var granade:PackedScene
var can_shoot = true

func _ready():
	player.change_direction.connect(change_direction)
	player.shoot_granade.connect(shoot_granade)


func change_direction():
	if scale.x != player.dir: 
		position.x += 2 * player.dir
		scale.x = player.dir

func shoot_granade():
	var granade_instance = granade.instantiate()
	granade_instance.dir = player.dir
	granade_instance.floor_index = floor_index

	if granade_instance.dir == 1: granade_instance.spawn_pos = global_position + Vector2(15, 0)
	elif granade_instance.dir == -1: granade_instance.spawn_pos = global_position + Vector2(-15, 0)
	
	if can_shoot:
		var old_granade = get_tree().get_first_node_in_group("Granade")
		get_parent().get_parent().get_parent().add_child(granade_instance)
		can_shoot = false
		if old_granade: old_granade.explode()


func _on_reload_timer_timeout():
	can_shoot = true