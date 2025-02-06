extends Floor

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("idle")
	player.flapping.connect(flapping)

# BATE LAS ALAS CUANDO EL JUGADOR SALTA EN EL AIRE
func flapping():
	animated_sprite_2d.play("flap")

# REGRESA A LA ANIMACIÓN NORMAL
func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.play("idle")
