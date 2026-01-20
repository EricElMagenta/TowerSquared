extends Floor

const GLIDING_FORCE = 20

# NODOS
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	player.change_direction.connect(change_direction)
	player.glide.connect(gliding)
	player.stop_glide.connect(stop_glide)
	animated_sprite_2d.play("inactive")

# CAMBIA DE DIRECCIÓN CUANDO EL JUGADOR SE VOLTEA Y AJUSTAR POSICIÓN
func change_direction():
	if scale.x != player.dir: 
		position.x -= 7 * player.dir
		scale.x = player.dir

func gliding():
	animated_sprite_2d.play("active")
	player.apply_gliding()

func stop_glide():
	animated_sprite_2d.play("inactive")
	player.stop_gliding()
