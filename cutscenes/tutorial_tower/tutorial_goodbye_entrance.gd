extends Node2D

@export var world_map:PackedScene


func change_scene():
	get_tree().change_scene_to_packed(world_map)
