extends Floor

@export var platform:PackedScene
var last_platform_lauched:Node2D = null

func _ready():
	player.change_direction.connect(change_direction)
	player.shoot_platform.connect(shoot_platform)

func change_direction():
	if scale.x != player.dir: 
		scale.x = player.dir


func shoot_platform():
	if is_instance_valid(last_platform_lauched): destroy_last_platform()

	var platform_instance = platform.instantiate()
	platform_instance.dir = player.dir
	
	if platform_instance.dir == 1: platform_instance.spawn_pos = global_position + Vector2(30, 0)
	elif platform_instance.dir == -1: platform_instance.spawn_pos = global_position + Vector2(-30, 0)
	
	last_platform_lauched = platform_instance
	AudioManager.play_bullet_shot()
	player.add_sibling(platform_instance)

func destroy_last_platform():
	last_platform_lauched.explode()