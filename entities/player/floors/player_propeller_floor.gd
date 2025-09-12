extends Floor

func _ready():
	player.change_direction.connect(change_direction)
	player.charge_propeller.connect(activate_propeller)
	player.release_propeller.connect(release_propeller)

func change_direction():
	if scale.x != player.dir || player.animated_sprite_2d.animation == "victory": 
		position.x -= 9 * player.dir
		scale.x = player.dir

func release_propeller():
	$AnimatedSprite2D.play("idle")
	player.remote_transform_2d.set_update_position(true)

# ACTIVA EL PROPULSOR (MIENTRAS MÁS SE CARGA, MÁS RÁPIDO AL SOLTAR)
func activate_propeller() -> void:
	var charge_bar = get_tree().get_first_node_in_group("charge_bar")
	charge_bar.fill_charge_bar(player.player_data.impulse / 10)
	
	player.remote_transform_2d.set_update_position(false)
	$AnimatedSprite2D.play("charge")
	player.charge_shake()
	player.velocity.y = 0
	player.player_data.impulse += (20 * player.dir)
	player.player_data.impulse = clamp(player.player_data.impulse, -player.player_data.max_propeller_impulse, player.player_data.max_propeller_impulse)
