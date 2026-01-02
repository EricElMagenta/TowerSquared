extends Sprite2D

var spawn_pos:Vector2

func _ready():
	global_position = spawn_pos
	await get_tree().create_timer(0.3).timeout
	queue_free()