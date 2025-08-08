extends Area2D

const BUBBLE_ORIGIN_OFFSET = 12

@export var bubble : PackedScene

# VARIABLES
@export var bubble_frequency := 3
var damage = 1
var can_spit_bubbles = true

# REBOTE DE LAS BURBUJAS
enum BOUNCEPOWER{
	LIGHT = 1,
	MEDIUM,
	STRONG
}
@export var selected_power = BOUNCEPOWER.LIGHT

# NODOS
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var bubble_timer = $BubbleTimer

func _ready():
	animated_sprite_2d.play("default")
	bubble_timer.start()

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.has_method("get_hit") && body.player_data.current_health > 0:
			body.get_hit(damage)

func _process(delta):
	if can_spit_bubbles:
		spit_bubbles()

func spit_bubbles():
	animated_sprite_2d.play("spit")
	can_spit_bubbles = false
	
	var bubble_instance = bubble.instantiate()
	bubble_instance.spawn_pos = Vector2(global_position.x, global_position.y - BUBBLE_ORIGIN_OFFSET)
	bubble_instance.bounce_multiplier = selected_power
	
	add_child(bubble_instance)

func _on_bubble_timer_timeout():
	animated_sprite_2d.play("default")
	await get_tree().create_timer(bubble_frequency).timeout
	can_spit_bubbles = true
	bubble_timer.start()
