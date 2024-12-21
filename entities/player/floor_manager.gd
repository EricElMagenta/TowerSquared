extends Node2D
class_name FloorManager

const FLOOR_HEIGHT = 17
const FLOOR_OFFSET = 5

var floors = []

func _ready():
	# Se obtiene la información de los power ups agarrados
	var items = get_tree().get_nodes_in_group("FloorItems")
	for item in items:
		item.got_floor.connect(add_floor)

func _process(delta) -> void:
	pass

func get_floors():
	pass

# AGREGAR PISOS 
func add_floor(floor_type:String) -> void:
	var new_floor_scene = load("res://entities/player/floors/" + floor_type + ".tscn").instantiate()
	new_floor_scene.add_to_group("PlayerFloors")
	new_floor_scene.floor_index = len(get_tree().get_nodes_in_group("PlayerFloors"))
	new_floor_scene.position.y -= FLOOR_HEIGHT * (new_floor_scene.floor_index +1) - FLOOR_OFFSET
	floors.append(new_floor_scene)
	call_deferred("add_child", new_floor_scene)

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
