extends Node2D
class_name FloorManager

const FLOOR_HEIGHT = 13
const FLOOR_OFFSET = 2

var floors = []
var player : Player

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
	
	floors.append(new_floor_scene)
	call_deferred("add_child", new_floor_scene)
	
	player.update_collision()
	player.update_player_abilities(floor_type)

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

# CORRIJE LA POSICIÓN DE LOS PISOS PARA ALINEARLOS CON LOS OTROS PISOS
func adjust_floor_position(new_floor:CharacterBody2D):
	if new_floor.name.to_lower() == "PlayerMouthFloor".to_lower():
		new_floor.position.x += 6 * player.dir
	
	if new_floor.name.to_lower() == "PlayerEyeFloor".to_lower():
		new_floor.position.x += 3.4 * player.dir
	
	if new_floor.name.to_lower() == "PlayerArmFloor".to_lower():
		new_floor.position.x += 8 * player.dir

# EXPLOTA A TODOS LOS PISOS
func explode() -> void:
	get_tree().call_group("PlayerFloors", "im_ded")
