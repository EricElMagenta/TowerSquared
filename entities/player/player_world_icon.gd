extends CharacterBody2D

# RESOURCES
@export var actions : PlayerInputActions

# NODOS
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var zone_detect = $ZoneDetect

# VARIABLES
const SPEED = 100

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	animated_sprite_2d.play("idle")
	position = GameManager.player_map_position

func _physics_process(delta):
	var input_direction = Input.get_vector(actions.left, actions.right, actions.up, actions.down)
	handle_colisions(input_direction)
	handle_animation(input_direction)
	detect_zone()
	move_and_slide()

##################################### FUNCIONES AUXILIARES ###############################
# MANEJAR LAS COLISIONES EN EL MAPA
func handle_colisions(input_direction):
	if !is_on_wall() || !is_on_ceiling() : velocity = input_direction * SPEED

# MANEJAR ANIMACIONES
func handle_animation(input_direction):
	var current_anim_state = ""
	
	# Caminar en diferentes direcciones (debe haber alguna mejor forma de hacer esto)
	if input_direction == Vector2(0,0):
		current_anim_state = "idle"
	elif input_direction[0] == 0:
		if input_direction[1] != 0: current_anim_state = "walk_up_down"
	elif input_direction[0] != 0:
		current_anim_state = "walk_left_right"
		if input_direction[0] < 0: animated_sprite_2d.scale.x = -1
		else: animated_sprite_2d.scale.x = 1
	
	animated_sprite_2d.play(current_anim_state)

func detect_zone():
	for area in zone_detect.get_overlapping_areas(): 
		if Input.is_action_just_pressed(actions.action):
			if area.has_method("go_to_next_zone"): 
				area.go_to_next_zone()
				GameManager.player_map_position = area.position + Vector2(0, 30)
				
			else: print(" no está disponible por ahora")

func _on_zone_detect_area_entered(area):
	if area is Area2D:
		AudioManager.play_map_zone_notification()
