extends CharacterBody2D
class_name Player

@export var actions : PlayerInputActions

@onready var state_machine = $StateMachine

@export var move_speed  = 200.0
@export var jump_force = -400.0
@export var accel = 100
@export var friction = 100

var input_vector: Vector2 = Vector2.ZERO # Movimiento del jugador

func _ready():
	# Se instancia la máquina de estados con el jugador
	state_machine.init(self)
	
	# Se obtiene la información de los power ups agarrados
	var items = get_tree().get_nodes_in_group("FloorItems")
	for item in items:
		item.got_floor.connect(add_floor)


func get_direction() -> Vector2:
	input_vector.x = Input.get_action_strength(actions.right) - Input.get_action_strength(actions.left)
	return input_vector.normalized()

func move(delta) -> void:
	# Add the gravity.
	if not is_on_floor(): velocity += get_gravity() * delta
	
	input_vector = get_direction()
	velocity = Vector2(input_vector[0] * move_speed, velocity.y)
	move_and_slide()

func jump() -> void:
		velocity.y = jump_force

func add_floor(floor_type:String) -> void:
	print(floor_type)
