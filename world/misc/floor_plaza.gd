extends Node2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D

func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon


func _on_exit_body_entered(body):
	if body is Player:
		get_tree().call_deferred("change_scene_to_file", "res://world/misc/world_map.tscn")
