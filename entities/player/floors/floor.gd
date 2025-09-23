extends CharacterBody2D
class_name Floor

@onready var player = get_tree().get_first_node_in_group("Player")

var floor_index : int

# EL PISO EXPLOTA CUANDO EL JUGADOR SE QUEDA SIN VIDA
func im_ded() -> void:
	var explosion = load("res://entities/player/floors/floor_explosion.tscn")
	var explosion_instance = explosion.instantiate()
	explosion_instance.scale = Vector2(2, 2)
	explosion_instance.position = self.position
	add_sibling(explosion_instance)
	self.visible = false
