extends Node

# VENTANA AL AGARRAR POWER UPS POR PRIMERA VEZ
var screen_normal_floor_saw:bool = false
var screen_eye_floor_saw:bool = false
var screen_mouth_floor_saw:bool = false
var screen_arm_floor_saw:bool = false
var screen_winged_floor_saw:bool = false
var screen_propeller_floor_saw:bool = false
var screen_suck_floor_saw:bool = false
var screen_granade_floor_saw:bool = false
var screen_portal_floor_saw:bool = false
var screen_glider_floor_saw:bool = false
var screen_platform_floor_saw:bool = false

# POSICIÓN DEL JUGADOR EN EL MAPA O AL PASAR POR PUERTAS
var player_plaza_position := Vector2(-421, 70)
var player_bar_enter_door_position := Vector2(47, 163)
var player_map_position := Vector2(195, 141)

# SELECCIÓN DE NIVELES (COMPLETADOS)
var cleared_levels = {
	"tutorialtower" = {
		"tutorial_1" : false,
		"tutorial_2" : false,
		"tutorial_3" : false,
		"tutorial_4" : false,
		"tutorial_5" : false
	},
	"seatower" = {
		"sea_1" : false,
		"sea_2" : false,
		"sea_3" : false,
		"sea_4" : false,
		"sea_5" : false,
		"sea_6" : false,
		"sea_7" : false
	},
	"technotower" = {
		"techno_1" : false,
		"techno_2" : false,
		"techno_3" : false,
		"techno_4" : false,
		"techno_5" : false,
		"techno_6" : false,
		"techno_7" : false
	},
	"airtower" = {
		"air_1" : false,
		"air_2" : false,
		"air_3" : false,
		"air_4" : false,
		"air_5" : false,
		"air_6" : false,
		"air_7" : false
	}
}

func mark_level_as_selectable(tower:String, level:String):
	cleared_levels[tower][level] = true

func is_level_selectable(tower:String, level:String):
	if cleared_levels[tower][level]: return true
	return false

# TORRES CONQUISTADAS
var tutorial_tower_clear = false
var sea_tower_clear = false
var air_tower_clear = false
var techno_tower_clear = false

func is_current_tower_cleared(current_tower:String) -> bool:
	match current_tower.to_lower():
		"tutorial": return tutorial_tower_clear
		"seatower": return sea_tower_clear
		"technotower": return techno_tower_clear
		"airtower": return air_tower_clear
	
	return false

# NIVEL SECRETO Y TIBURÓN
var sharked_player = false
var scared_guard = false

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
