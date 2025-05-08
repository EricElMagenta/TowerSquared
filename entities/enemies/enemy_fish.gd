extends StaticBody2D

const BUBBLE_ORIGIN_OFFSET = 12

@export var bubble : PackedScene
var damage = 1
var can_spit_bubbles = true

enum BOUNCEPOWER{
	LIGHT = 1,
	MEDIUM,
	STRONG
}

@export var selected_power = BOUNCEPOWER.LIGHT

func _ready():
	$AnimatedSprite2D.play("default")
	$BubbleTimer.start()

func _physics_process(delta):
	# Detecta al jugador constantemente
	for body in $Hitbox.get_overlapping_bodies():
		if body.has_method("get_hit") && body.player_data.current_health > 0:
			body.get_hit(damage)

func _process(delta):
	if can_spit_bubbles:
		spit_bubbles()

func spit_bubbles():
	$AnimatedSprite2D.play("spit")
	can_spit_bubbles = false
	
	var bubble_instance = bubble.instantiate()
	bubble_instance.spawn_pos = Vector2(global_position.x, global_position.y - BUBBLE_ORIGIN_OFFSET)
	bubble_instance.bounce_multiplier = selected_power
	
	add_child(bubble_instance)

func _on_bubble_timer_timeout():
	$AnimatedSprite2D.play("default")
	await get_tree().create_timer(2).timeout
	can_spit_bubbles = true
	$BubbleTimer.start()
