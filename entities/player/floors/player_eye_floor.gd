extends Floor

@onready var sprite_2d = $Sprite2D

func _ready():
	player.change_direction.connect(change_direction)
	player.shoot_fireball.connect(shoot_fireball)
	
func change_direction():
	sprite_2d.flip_h = (player.input_vector.x < 0)

func shoot_fireball():
	print("PEW!!")
