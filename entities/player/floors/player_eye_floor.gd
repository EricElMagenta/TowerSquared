extends Floor

@export var fireball:PackedScene
@onready var animated_sprite_2d = $AnimatedSprite2D

var can_shoot = true

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
	
	if fireball_instance.dir == 1: fireball_instance.spawm_pos = global_position + Vector2(25, 0)
	elif fireball_instance.dir == -1: fireball_instance.spawm_pos = global_position + Vector2(-25, 0)
	
	# RELOAD
	if can_shoot: 
		animated_sprite_2d.play("shoot")
		get_tree().root.add_child(fireball_instance)
		can_shoot = false

# RECARGAR DISPARO
func _on_reload_timer_timeout():
	can_shoot = true

# REGRESA A LA ANIMACIÓN NORMAL
func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.play("idle")
