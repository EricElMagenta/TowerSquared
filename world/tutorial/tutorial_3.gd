extends Node2D

# VARIABLES
@export var next_level:PackedScene

# NODOS
@onready var door_stone = $DoorStone
@onready var health_container = $CanvasLayer/HealthContainer
@onready var player = $Player
@onready var button = $Button

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	door_stone.level_finished.connect(go_to_next_level)
	health_container.set_max_health(player.player_data.max_health)
	player.health_changed.connect(health_container.update_health)
	button.button_pressed.connect(open_dohhr)
	
	door_stone.sprite_2d.frame = 1

func go_to_next_level():
	get_tree().call_deferred("change_scene_to_packed", next_level)

func open_dohhr():
	door_stone.sprite_2d.frame = 0
