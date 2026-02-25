extends Node2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var collision_end = $StaticBody2D/CollisionsEnd
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var camera_2d = $Camera2D
@onready var player = $PlayerWorldIcon

var shake_strength := 0.0
var decay_rate := 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.change_song("world_map")
	RenderingServer.set_default_clear_color(Color.BLACK)
	if GameManager.is_end_tower_unlocked(): island_borders_2()
	else: island_borders_1()

func _process(delta):
	shake_strength = lerp(shake_strength, 0.0, decay_rate * delta)
	camera_2d.offset = shake()

func island_borders_1():
	collision_polygon_2d.disabled = false
	collision_end.disabled = true

func island_borders_2():
	if !GameManager.end_tower_emerged:
		player.can_move = false
		apply_shake()
		await get_tree().create_timer(0.5).timeout
		apply_shake()
		await get_tree().create_timer(0.5).timeout
		apply_shake()
		await get_tree().create_timer(0.5).timeout
		apply_shake()
		await get_tree().create_timer(0.5).timeout
		apply_shake()
		await get_tree().create_timer(0.5).timeout
		player.can_move = true
		GameManager.end_tower_emerged = true

	collision_polygon_2d.disabled = true
	collision_end.disabled = false
	
func apply_shake():
	AudioManager.play_earthquake()
	shake_strength = 10

func shake():
	return Vector2(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength)
	)