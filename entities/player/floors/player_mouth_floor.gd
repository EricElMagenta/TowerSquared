extends Floor

@onready var sprite_2d = $Sprite2D
@onready var eat_area = $EatArea

func _ready():
	player.change_direction.connect(change_direction)
	
func change_direction():
	sprite_2d.flip_h = (player.input_vector.x < 0)
	eat_area.scale.x = player.dir
