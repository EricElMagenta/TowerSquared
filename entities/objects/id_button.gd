extends Node2D

# NODOS
@onready var sprite_2d = $Sprite2D

# VARIABLES
@export var button_id:int
var walls:Array[Node]
var my_wall:StaticBody2D
var is_pressed := false

# FUNCIONES
func _ready():
	walls = get_tree().get_nodes_in_group("FakeWallId")
	link_wall()

# ENLAZAR CON PARED
func link_wall():
	for wall in walls:
		if button_id == wall.wall_id: my_wall = wall 

# MATAR PARED AL APRETAR BOTÓN
func _on_push_area_body_entered(body:Node2D):
	if (body is Granade || body is PlayerProjectile || body is Player) && !is_pressed:
		is_pressed = true
		sprite_2d.frame = 1
		if is_instance_valid(my_wall):
			AudioManager.play_button_press()
			my_wall.lower_buttons_required()