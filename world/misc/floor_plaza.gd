extends Node2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var player = $Player

func _ready():
	player.position = GameManager.player_plaza_position
	AudioManager.change_song("floor_plaza")
	RenderingServer.set_default_clear_color(Color.BLACK)
	polygon_2d.polygon = collision_polygon_2d.polygon
	if player: player.enter_door.connect(entering_door)
	else: return

func _on_exit_body_entered(body):
	if body is Player:
		get_tree().call_deferred("change_scene_to_file", "res://world/misc/world_map.tscn")

func entering_door():
	if player:
		GameManager.player_plaza_position = player.position
	get_tree().change_scene_to_file("res://world/misc/floor_bar.tscn")
