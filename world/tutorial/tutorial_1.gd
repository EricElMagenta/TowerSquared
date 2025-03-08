extends Node2D

# VARIABLES
@export var next_level:PackedScene

# NODOS
@onready var door_stone = $DoorStone
@onready var health_container = $CanvasLayer/HealthContainer
@onready var player = $Player

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	door_stone.level_finished.connect(go_to_next_level)
	health_container.set_max_health(player.player_data.max_health)
	#health_container.update_health(player.player_data.max_health) # ¿Es esta línea necesaria?
	player.health_changed.connect(health_container.update_health)

func go_to_next_level():
	get_tree().call_deferred("change_scene_to_packed", next_level)
