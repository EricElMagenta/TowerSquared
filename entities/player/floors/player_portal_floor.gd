extends Floor

# NODOS
@export var warp:PackedScene
@export var delete_sign:PackedScene
@onready var animated_sprite_2d = $AnimatedSprite2D

# CONSTANTES
const PORTAL_A = "A"
const PORTAL_Z = "Z"
const PORTAL_DEL = "_del"
const MODES = [PORTAL_A, PORTAL_Z, PORTAL_DEL]

# VARIABLES
var state_a:bool
var state_z:bool
var state_del:bool
var can_shoot := true
var mode_index = 0

# FUNCIONES
func _ready():
	change_to_A()
	player.change_direction.connect(change_direction)
	player.shoot_portal.connect(shoot_portal)
	player.change_portal.connect(change)

func change_direction():
	if scale.x != player.dir: 
		position.x += 10 * player.dir
		scale.x = player.dir

func shoot_portal():
	# DISPARAR PORTALES
	if MODES[mode_index] != PORTAL_DEL:
		var warp_instance = warp.instantiate()
		warp_instance.dir = player.dir

		if warp_instance.dir == 1: warp_instance.spawn_pos = global_position + Vector2(5, 0)
		elif warp_instance.dir == -1: warp_instance.spawn_pos = global_position + Vector2(-5, 0)
		
		if state_a: warp_instance.state = PORTAL_A
		elif state_z: warp_instance.state = PORTAL_Z

		if can_shoot:
			can_shoot = false
			AudioManager.play_shoot()
			get_parent().get_parent().get_parent().add_child(warp_instance)
	
	# BORRAR PORTALES
	else:
		var delete_instance = delete_sign.instantiate()
		delete_instance.spawn_pos = global_position + Vector2(player.dir * 45, 0) 
		get_parent().get_parent().get_parent().add_child(delete_instance)

		AudioManager.play_drop_object()
		if get_tree().get_first_node_in_group("PortalA"): get_tree().get_first_node_in_group("PortalA").erase_portal()
		if get_tree().get_first_node_in_group("PortalZ"): get_tree().get_first_node_in_group("PortalZ").erase_portal()

# CAMBIAR PORTAL
func change():
	mode_index += 1
	if mode_index >= len(MODES): 
		mode_index = 0

	match MODES[mode_index]:
		PORTAL_A: change_to_A()
		PORTAL_Z: change_to_Z()
		PORTAL_DEL: change_to_del()

func change_to_A():
	state_a = true
	state_z = false
	state_del = false
	animated_sprite_2d.play(MODES[mode_index])		

func change_to_Z():
	state_a = false
	state_z = true
	state_del = false
	animated_sprite_2d.play(MODES[mode_index])

func change_to_del():
	state_a = false
	state_z = false
	state_del = true
	animated_sprite_2d.play(MODES[mode_index])

# RECARGAR DISPARO
func _on_reload_timer_timeout():
	can_shoot = true
