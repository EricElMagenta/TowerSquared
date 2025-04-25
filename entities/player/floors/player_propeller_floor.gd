extends Floor

func _ready():
	player.change_direction.connect(change_direction)

func change_direction():
	if scale.x != player.dir: 
		position.x -= 9 * player.dir
		scale.x = player.dir
