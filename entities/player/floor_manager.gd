extends Node2D
class_name FloorManager

# RESOURCES
@export var floor_count_data : FloorCountData

# CONSTANTES PARA AJUSTAR LA ALTURA DE LOS PISOS
const FLOOR_HEIGHT = 13
const FLOOR_OFFSET = 2

# CONSTANTES PARA ALINEAR NUEVOS PISOS
const PLAYER_MOUTH_FLOOR_OFFSET = 6
const PLAYER_EYE_FLOOR_OFFSET = 3.4
const PLAYER_ARM_FLOOR_OFFSET = 8
const PLAYER_PROPELLER_FLOOR_OFFSET = 4.5
const PLAYER_FISH_FLOOR_OFFSET = 7.5
const PLAYER_SUCK_FLOOR_OFFSET = 11.5
const PLAYER_PORTAL_FLOOR_OFFSET = 5

# CONSTANTES PARA VOLTEAR PISOS QUE TAPAN LA ANIMACIÓN DE VICTORIA
const VICTORY_FLIP_PLAYER_FISH_FLOOR_OFFSET = 15
const VICTORY_FLIP_PLAYER_PROPELLER_FLOOR_OFFSET = 9

# VARIABLES
var floors = []
var player : Player
var max_air_jumps = 0 # Saltar en el aire
var remaining_air_jumps = 0 # Saltos en el aire restantes

func _ready():
	# Se obtiene la información de los power ups agarrados
	var items = get_tree().get_nodes_in_group("FloorItems")
	for item in items:
		item.got_floor.connect(add_floor)

func init(new_player:Player):
	player = new_player

# AGREGAR PISOS 
func add_floor(floor_type:String) -> void:
	
	var new_floor_scene = load("res://entities/player/floors/" + floor_type + ".tscn").instantiate()
	new_floor_scene.add_to_group("PlayerFloors")
	new_floor_scene.floor_index = len(get_tree().get_nodes_in_group("PlayerFloors"))
	new_floor_scene.position.y -= FLOOR_HEIGHT * (new_floor_scene.floor_index +1) - FLOOR_OFFSET
	new_floor_scene.scale.x = player.dir
	adjust_floor_position(new_floor_scene)
	
	add_floor_to_count_data(floor_type)
	floors.append(new_floor_scene)
	call_deferred("add_child", new_floor_scene)
	
	AudioManager.play_get_floor()
	player.update_collision()
	if floor_type == "player_winged_floor": update_jumps()

# SWAP DE PISOS HACIA ABAJO
func swap_floors_down():
	for i in floors.size():
		if i != len(floors)-1: 
			var aux_floor_index = floors[i].floor_index
			var floor_aux = floors[i]
			var floor_position_aux = floors[i].position.y
			
			floors[i].floor_index = floors[i+1].floor_index
			floors[i+1].floor_index = aux_floor_index
			
			floors[i].position.y = floors[i+1].position.y
			floors[i+1].position.y = floor_position_aux
			
			floors[i] = floors[i+1]
			floors[i+1] = floor_aux

# SWAP DE PISOS HACIA ARRIBA
func swap_floors_up():
	for i in range(floors.size()-1, -1, -1):
		if i != len(floors)-1: 
			var aux_floor_index = floors[i].floor_index
			var floor_aux = floors[i]
			var floor_position_aux = floors[i].position.y
			
			floors[i].floor_index = floors[i-1].floor_index
			floors[i-1].floor_index = aux_floor_index
			
			floors[i].position.y = floors[i-1].position.y
			floors[i-1].position.y = floor_position_aux
			
			floors[i] = floors[i-1]
			floors[i-1] = floor_aux

# OBTENER TOTAL DE PISOS
func get_total_floors():
	return len(floors)
	
# CONTAR CANTIDAD DE PISOS OBTENIDOS POR TIPO (SOLO PARA PISOS CUYO EFECTO INCLUYE CANTIDAD DE COPIAS)
func add_floor_to_count_data(floor_type:String) -> void:
	var add_to_count = floor_type.erase(0,7)
	floor_count_data.floor_count_dict[add_to_count] += 1

func get_this_floor_count(floor_type:String) -> int:
	return floor_count_data.floor_count_dict[floor_type]

func update_jumps() -> void:
	max_air_jumps += 1
	remaining_air_jumps += 1

# REINICIA EL CONTEO DE PISOS
func restart_floor_count() -> void:
	floor_count_data = FloorCountData.new()
	
# CORRIJE LA POSICIÓN DE LOS PISOS PARA ALINEARLOS CON LOS OTROS PISOS
func adjust_floor_position(new_floor:CharacterBody2D):
	if new_floor.name.to_lower() == "PlayerMouthFloor".to_lower():
		new_floor.position.x += PLAYER_MOUTH_FLOOR_OFFSET * player.dir
	
	if new_floor.name.to_lower() == "PlayerEyeFloor".to_lower():
		new_floor.position.x += PLAYER_EYE_FLOOR_OFFSET * player.dir
	
	if new_floor.name.to_lower() == "PlayerArmFloor".to_lower():
		new_floor.position.x += PLAYER_ARM_FLOOR_OFFSET * player.dir
		
	if new_floor.name.to_lower() == "PlayerPropellerFloor".to_lower():
		new_floor.position.x -= PLAYER_PROPELLER_FLOOR_OFFSET * player.dir
		
	if new_floor.name.to_lower() == "PlayerFishFloor".to_lower():
		new_floor.position.x -= PLAYER_FISH_FLOOR_OFFSET * player.dir

	if new_floor.name.to_lower() == "PlayerSuckFloor".to_lower():
		new_floor.position.x += PLAYER_SUCK_FLOOR_OFFSET * player.dir

	if new_floor.name.to_lower() == "PlayerPortalFloor".to_lower():
		new_floor.position.x += PLAYER_PORTAL_FLOOR_OFFSET * player.dir
		

# EXPLOTA A TODOS LOS PISOS
func explode() -> void:
	AudioManager.play_explosion()
	get_tree().call_group("PlayerFloors", "im_ded")

func flip_first_overlapping_floor():
	if get_total_floors() > 0:
		match floors[0].name:
			
			"PlayerFishFloor":
				floors[0].scale.x *= -1
				floors[0].position.x += VICTORY_FLIP_PLAYER_FISH_FLOOR_OFFSET * player.dir

			"PlayerPropellerFloor": 
				floors[0].scale.x *= -1
				floors[0].position.x += VICTORY_FLIP_PLAYER_PROPELLER_FLOOR_OFFSET * player.dir
