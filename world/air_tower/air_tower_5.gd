extends Node2D

# VARIABLES
@export var next_level:PackedScene


# NODOS
@onready var door_stone = $DoorStone
@onready var health_container = $CanvasLayer/HealthContainer
@onready var player = $Player
@onready var scene_transition = $SceneTransition

func _ready():
	if !AudioManager.music.playing || AudioManager.current_music.to_lower() != "air_tower": AudioManager.change_song("air_tower")
	RenderingServer.set_default_clear_color(Color.BLACK)

	# TRANCISIÓN DEL NIVEL
	scene_transition.new_level_transition()
	await get_tree().create_timer(0.5).timeout

	# TERMINAR NIVEL
	door_stone.level_finished.connect(go_to_next_level)

	# VIDA DEL JUGADOR
	health_container.set_max_health(player.player_data.max_health)
	#health_container.update_health(player.player_data.max_health) # ¿Es esta línea necesaria?
	player.health_changed.connect(health_container.update_health)

	#MARCA EL NIVEL COMO SELECCIONABLE
	GameManager.mark_level_as_selectable("airtower", "air_5")
	
func go_to_next_level():
	scene_transition.next_level_transition()
	await get_tree().create_timer(0.5).timeout
	get_tree().call_deferred("change_scene_to_packed", next_level)