extends Node2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D

func _ready():
	AudioManager.change_song("floor_plaza")
	RenderingServer.set_default_clear_color(Color.BLACK)
	polygon_2d.polygon = collision_polygon_2d.polygon
	if $Player: $Player.enter_door.connect(entering_door)
	else: return

func entering_door():
	get_tree().change_scene_to_file("res://world/misc/floor_plaza.tscn")
