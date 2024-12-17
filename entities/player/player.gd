extends CharacterBody2D
class_name Player

@onready var state_machine = $StateMachine

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const accel = 100
const friction = 100

var input_vector: Vector2 = Vector2.ZERO # Movimiento del jugador

func _ready():
	# Se instancia la máquina de estados con el jugador
	state_machine.init(self)

func get_input_vector() -> Vector2:
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	return input_vector.normalized()

func move(delta):
	# Add the gravity.
	if not is_on_floor(): velocity += get_gravity() * delta
	velocity = Vector2(input_vector[0] * SPEED, velocity.y)
	move_and_slide()
