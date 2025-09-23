extends Node

# VENTANA AL AGARRAR POWER UPS POR PRIMERA VEZ
var screen_normal_floor_saw:bool = false
var screen_eye_floor_saw:bool = false
var screen_mouth_floor_saw:bool = false
var screen_arm_floor_saw:bool = false
var screen_winged_floor_saw:bool = false
var screen_propeller_floor_saw:bool = false
var screen_suck_floor_saw:bool = false

# POSICIÓN DEL JUGADOR EN EL MAPA O AL PASAR POR PUERTAS
var player_map_position := Vector2(195, 141)
var player_plaza_position := Vector2(-421, 70)

# IDIOMAS
var current_lang = "es"

func restart_scene():
	get_tree().call_deferred("reload_current_scene")

func _input(event):
	if event.is_action_pressed("change_language"):
		if current_lang == "es":
			current_lang = "en"
			TranslationServer.set_locale("en")
		
		elif current_lang == "en":
			current_lang = "es"
			TranslationServer.set_locale("es")
