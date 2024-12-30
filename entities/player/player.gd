extends CharacterBody2D
class_name Player

@export var actions : PlayerInputActions

@onready var floor_manager = $FloorManager
@onready var state_machine = $StateMachine
@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var move_speed  = 200.0
@export var jump_force = -300.0
@export var air_jump_force = -300
@export var accel = 100
@export var friction = 100


var input_vector: Vector2 = Vector2.ZERO # Movimiento del jugador

# VARIABLES DEL JUGADOR (POWER UP Y WEÁS)
var max_air_jumps = 0 # Saltar en el aire
var remaining_air_jumps = 0 # Saltos en el aire restantes

func _ready():
	# Se instancia la máquina de estados con el jugador
	state_machine.init(self)
	
	# Se instancia el floor manager
	floor_manager.init(self)
	
func _process(delta):
	print(remaining_air_jumps)

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

func air_jump()-> void:
	velocity.y = air_jump_force

# ALTERNAR PISOS AL OPPRIMIR EL SWAP
func swap_floors() -> void:
	if Input.is_action_just_pressed(actions.swap_down):
		floor_manager.swap_floors_down()
	elif Input.is_action_just_pressed(actions.swap_up):
		floor_manager.swap_floors_up()

# MODIFICAR COLISIONES
func update_collision():
	if floor_manager.get_total_floors() == 1:
		collision_shape_2d.scale.x += 0.3
	collision_shape_2d.scale.y += 1.56
	collision_shape_2d.position.y -= 6.24

# OBTENER EL TIPO DE PISO OBTENIDO
func update_player_abilities(new_floor_type: String):
	print(new_floor_type)
	if new_floor_type.to_lower() == "player_winged_floor":
		max_air_jumps += 1

# GESTIONA LAS ANIMACIONES DEL JUGADOR
func player_animations(current_animation:String):
	# Voltea al jugador según la dirección.
	if input_vector.x: 
		animated_sprite_2d.flip_h = (input_vector.x < 0)
	
	if current_animation.to_lower() == "fall" || current_animation.to_lower() == "airjump":
		current_animation = "Jump"
	animated_sprite_2d.play(current_animation.to_lower())
	
