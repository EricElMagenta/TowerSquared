extends State
class_name Victory

func Enter():
	parent.player_animations(self.name)
	
#	Corrije la posición de las extremidades al hacer la animación de victoria.
	parent.animated_sprite_2d.position = Vector2(parent.animated_sprite_2d.offset.x - 10 * parent.dir, parent.animated_sprite_2d.offset.y - 13)
	
func Physics_Update(_delta:float):
	pass

func Exit():
	pass
