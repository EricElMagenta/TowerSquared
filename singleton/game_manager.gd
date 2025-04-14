extends Node

# VENTANA AL AGARRAR POWER UPS POR PRIMERA VEZ
var screen_normal_floor_saw:bool = false
var screen_eye_floor_saw:bool = false
var screen_mouth_floor_saw:bool = false
var screen_arm_floor_saw:bool = false
var screen_winged_floor_saw:bool = false

# POSICIÓN DEL JUGADOR EN EL MAPA
var player_map_position := Vector2(195, 141)

func restart_scene():
	get_tree().call_deferred("reload_current_scene")
