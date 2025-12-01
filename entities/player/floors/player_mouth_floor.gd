extends Floor

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	player.change_direction.connect(change_direction)
	animated_sprite_2d.play("idle")

# CAMBIA DE DIRECCIÓN CUANDO EL JUGADOR SE VOLTEA Y AJUSTAR POSICIÓN
func change_direction():
	if scale.x != player.dir: 
		position.x += 12 * player.dir
		scale.x = player.dir

# MASCA LOS OBJETOS QUE ENTREN AL AREA Y SE PUEDAN MASCAR
func _on_eat_area_body_entered(body):
	if body.has_method("get_eaten"):
		AudioManager.play_chomp()
		animated_sprite_2d.play("chomp")
		body.get_eaten()
	
# REGRESA A LA ANIMACIÓN NORMAL PARA LA BOCA
func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.play("idle")
