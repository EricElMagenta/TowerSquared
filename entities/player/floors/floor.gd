extends CharacterBody2D
class_name Floor

@onready var player = get_tree().get_first_node_in_group("Player")

var floor_index : int
