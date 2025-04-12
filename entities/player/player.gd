extends CharacterBody2D
class_name Player

# SEÑALES
signal health_changed
signal change_direction
signal shoot_fireball
signal flapping
signal action
signal stop_action

# RESOURCES
@export var actions : PlayerInputActions
@export var player_data : PlayerData

# NODOS
@onready var floor_manager = $FloorManager
@onready var state_machine = $StateMachine
@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var immunity_timer = $ImmunityTimer
@onready var dialogue_area = $DialogueArea
@onready var talk_prompt = $TalkPrompt


# VARIABLES DEL JUGADOR (POWER UP Y WEÁS)
var input_vector: Vector2 = Vector2.ZERO # Movimiento del jugador
var max_air_jumps = 0 # Saltar en el aire
var remaining_air_jumps = 0 # Saltos en el aire restantes
var has_eyes = false
var has_mouth = false
var has_arms = false
var dir = 1
var damage_blink = false
var knockback = Vector2.ZERO
var talking_to : CharacterBody2D = null

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	# Se instancia la máquina de estados con el jugador
	state_machine.init(self)
	
	# Se instancia el floor manager
	floor_manager.init(self)
	
	# Resetear power ups después de morir
	reset_power_ups()
	
	# Resetea la vida al máximo
	player_data.current_health = player_data.max_health

#func _physics_process(delta):
	#if Input.is_action_just_pressed(actions.up):
		#print("juejeje")

##################################### FUNCIONES AUXILIARES ###############################
# OBTENER DIRECCIÓN
func get_direction() -> Vector2:
	
	# Obtener los inputs para moverse izquierda o derecha
	input_vector.x = Input.get_action_strength(actions.right) - Input.get_action_strength(actions.left)
	
	# Actualiza la dirección en la que mira el jugador
	if input_vector.x != 0:
		if input_vector.x == 1: dir = 1
		elif input_vector.x == -1: dir = -1
		
	return input_vector

# MOVERSE
func move(delta) -> Vector2:
	# Add the gravity.
	if not is_on_floor(): velocity += get_gravity() * delta
	
	input_vector = get_direction()
	velocity = Vector2(input_vector[0] * player_data.move_speed, velocity.y)
	move_and_slide()
	return input_vector

# SALTAR
func jump() -> void:
	velocity.y = player_data.jump_force

func air_jump()-> void:
	velocity.y = player_data.air_jump_force
	flapping.emit()

# ALTERNAR PISOS AL OPPRIMIR EL SWAP
func swap_floors() -> void:
	if Input.is_action_just_pressed(actions.swap_down):
		floor_manager.swap_floors_down()
	elif Input.is_action_just_pressed(actions.swap_up):
		floor_manager.swap_floors_up()

# MODIFICAR COLISIONES
func update_collision() -> void:
	if floor_manager.get_total_floors() == 1:
		collision_shape_2d.scale.x += 0.3
	collision_shape_2d.scale.y += 1.56
	collision_shape_2d.position.y -= 6.24

# RESETEA LOS POWER UPS
func reset_power_ups():
	has_eyes = false
	has_arms = false
	has_mouth = false
	max_air_jumps = 0

# DETECTAR EL TIPO DE PISO OBTENIDO Y ACTUALIZAR HABILIDADES DEL JUGADOR
func update_player_abilities(new_floor_type: String) -> void:
	if new_floor_type.to_lower() == "player_winged_floor":	
		max_air_jumps += 1
		remaining_air_jumps += 1
		
	if new_floor_type.to_lower() == "player_eye_floor":	has_eyes = true
	if new_floor_type.to_lower() == "player_mouth_floor": has_mouth = true
	if new_floor_type.to_lower() == "player_arm_floor": has_arms = true

# GESTIONA LAS ANIMACIONES DEL JUGADOR
func player_animations(current_animation:String) -> void:
	# Voltea al jugador según la dirección.
	if input_vector.x: 
		animated_sprite_2d.flip_h = (input_vector.x < 0)
		change_direction.emit()
	
	if current_animation.to_lower() == "fall" || current_animation.to_lower() == "airjump":
		current_animation = "Jump"
	animated_sprite_2d.play(current_animation.to_lower())

# RECIBIR DAÑO
func get_hit(damage) -> void:
	if !damage_blink:
		player_data.current_health -= damage
		get_hit_immunity()
		if player_data.current_health <= 0: ded()
		velocity.y = player_data.knockback_force.y

# IMNUNIDAD POST DAÑO
func get_hit_immunity() -> void:
	health_changed.emit(player_data.current_health)
	immunity_timer.start()
	while immunity_timer.time_left > 0:
		damage_blink = true
		self.modulate.a = 0
		await get_tree().create_timer(0.2).timeout
		self.modulate.a = 1
		await get_tree().create_timer(0.2).timeout
	damage_blink = false

func ded() -> void:
	get_tree().call_deferred("reload_current_scene")


# EMPUJAR OBJECTOS EMPUJABLES
#func push_object():
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#
		## Obtiene el objeto con el que colisiona
		#var collision_object = collision.get_collider()
		#
		## Empuja el objeto
		#if collision_object.is_in_group("pushable"):
			#if abs(collision_object.get_linear_velocity().x) < player_data.move_speed && has_arms:
				#collision_object.apply_central_impulse(collision.get_normal() * -player_data.push_force)
