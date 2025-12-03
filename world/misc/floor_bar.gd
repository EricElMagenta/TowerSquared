extends Node2D

const GUARD_SCARED_OFFSET = 70

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var npc_guard = $NPC/NpcGuard
@onready var secret_door = $SecretDoor
@onready var player = $Player

var guard_dialogue = "guard_floor_greet"
var guard_scared_dialogue = "guard_floor_scared_greet"

func _ready():
	player.position = GameManager.player_bar_enter_door_position
	AudioManager.change_song("floor_plaza")
	RenderingServer.set_default_clear_color(Color.BLACK)
	polygon_2d.polygon = collision_polygon_2d.polygon

	if GameManager.sharked_player || GameManager.scared_guard:
		GameManager.scared_guard = true
		npc_guard.dialogue = guard_scared_dialogue
		npc_guard.position.x -= GUARD_SCARED_OFFSET
		npc_guard.play("scared")

	if $Player: $Player.enter_door.connect(entering_door)
	else: return

	if $Player: $Player.enter_secret_door.connect(entering_secret_door)
	else: return

func entering_door():
	if player: GameManager.player_bar_enter_door_position = player.position
	get_tree().change_scene_to_file("res://world/misc/floor_plaza.tscn")

func entering_secret_door():
	if player: GameManager.player_bar_enter_door_position = player.position
	GameManager.sharked_player = false
	get_tree().change_scene_to_file("res://world/misc/secret_level.tscn")