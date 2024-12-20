extends Node2D
class_name FloorManager

const FLOOR_HEIGHT = 17
const FLOOR_OFFSET = 5

func _ready():
	# Se obtiene la información de los power ups agarrados
	var items = get_tree().get_nodes_in_group("FloorItems")
	for item in items:
		item.got_floor.connect(add_floor)

func _process(delta) -> void:
	pass

func add_floor(floor_type:String) -> void:
	var new_floor_scene = load("res://entities/player/" + floor_type + ".tscn").instantiate()
	new_floor_scene.add_to_group("PlayerFloors")
	new_floor_scene.position.y -= FLOOR_HEIGHT * (len(get_tree().get_nodes_in_group("PlayerFloors"))+1) - FLOOR_OFFSET
	call_deferred("add_child", new_floor_scene)
