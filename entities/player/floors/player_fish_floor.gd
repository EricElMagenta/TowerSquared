extends Floor

func _ready():
	player.change_direction.connect(change_direction)
	$AnimatedSprite2D.play("idle")

func _physics_process(_delta):
	if player.state_machine.current_state.name == "SwimIdle" || player.state_machine.current_state.name == "SwimMove":
		$AnimatedSprite2D.play("swimming")
	else:
		$AnimatedSprite2D.play("idle")

func change_direction():
	if scale.x != player.dir || player.animated_sprite_2d.animation == "victory": 
		position.x -= 15 * player.dir
		scale.x = player.dir
