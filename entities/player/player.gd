extends CharacterBody2D
class_name Player

@export var actions : PlayerInputActions

@onready var floor_manager = $FloorManager
@onready var state_machine = $StateMachine
@onready var collision_shape_2d = $CollisionShape2D

@export var move_speed  = 200.0
@export var jump_force = -500.0
@export var accel = 100
@export var friction = 100

var input_vector: Vector2 = Vector2.ZERO # Movimiento del jugador

func _ready():
	# Se instancia la máquina de estados con el jugador
	state_machine.init(self)
	
	# Se instancia el floor manager
	floor_manager.init(self)
	
func _process(delta):
	print(floor_manager.get_total_floors())

##################################### FUNCIONES AUXILIARES ###############################
# OBTENER DIRECCIÓN
func get_direction() -> Vector2:
	input_vector.x = Input.get_action_strength(actions.right) - Input.get_action_strength(actions.left)
	return input_vector.normalized()

# MOVERSE
func move(delta) -> Vector2:
	# Add the gravity.
	if not is_on_floor(): velocity += get_gravity() * delta
	
	input_vector = get_direction()
	velocity = Vector2(input_vector[0] * move_speed, velocity.y)
	move_and_slide()
	return input_vector

# SALTAR
func jump() -> void:
		velocity.y = jump_force

# ALTERNAR PISOS AL OPPRIMIR EL SWAP
func swap_floors() -> void:
	if Input.is_action_just_pressed(actions.swap_down):
		floor_manager.swap_floors_down()
	elif Input.is_action_just_pressed(actions.swap_up):
		floor_manager.swap_floors_up()

func update_collision():
	if floor_manager.get_total_floors() == 1:
		collision_shape_2d.scale.x += 0.3
	collision_shape_2d.scale.y += 1.56
	collision_shape_2d.position.y -= 6.24
