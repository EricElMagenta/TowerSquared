extends Floor

func _ready():
	player.change_direction.connect(change_direction)
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if player.state_machine.current_state.name == "SwimIdle" || player.state_machine.current_state.name == "SwimMove":
		$AnimatedSprite2D.play("swimming")
	else:
		$AnimatedSprite2D.play("idle")

func change_direction():
	if scale.x != player.dir: 
		position.x -= 15 * player.dir
		scale.x = player.dir
