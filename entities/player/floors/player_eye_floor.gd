extends Floor

#VARIABLES
@export var fireball:PackedScene
var can_shoot = true

# NODOS
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var shoot_area = $ShootArea

func _ready():
	player.change_direction.connect(change_direction)
	player.shoot_fireball.connect(shoot_fireball)
	animated_sprite_2d.play("idle")
	
# CAMBIA DE DIRECCIÓN CUANDO EL JUGADOR SE VOLTEA Y AJUSTAR POSICIÓN
func change_direction():
	if scale.x != player.dir: 
		position.x += 6.8 * player.dir
		scale.x = player.dir

# DISPARAR BOLA DE FUEGO
func shoot_fireball():
	var fireball_instance = fireball.instantiate()
	fireball_instance.dir = player.dir
	
	if fireball_instance.dir == 1: fireball_instance.spawm_pos = global_position + Vector2(15, 0)
	elif fireball_instance.dir == -1: fireball_instance.spawm_pos = global_position + Vector2(-15, 0)
	
	# RELOAD
	if can_shoot: 
		if len(shoot_area.get_overlapping_bodies()) == 0: 
			animated_sprite_2d.play("shoot")
			AudioManager.play_shoot()
			get_tree().root.add_child(fireball_instance)
			can_shoot = false
		else:
			AudioManager.play_inavlid_action()


# RECARGAR DISPARO
func _on_reload_timer_timeout():
	can_shoot = true

# REGRESA A LA ANIMACIÓN NORMAL
func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.play("idle")
