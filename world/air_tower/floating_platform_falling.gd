extends AnimatableBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D
var falling_speed = 1
var is_falling = false
var starting_point:Vector2

func _ready():
	starting_point = position

func _physics_process(delta):
	if is_falling: 
		move_and_collide(Vector2(0, falling_speed * delta))
		falling_speed += 20
	

func _on_area_2d_body_entered(body:Node2D):
	if body is Player: 
		animated_sprite_2d.play("falling")
		AudioManager.play_inavlid_action()
		await get_tree().create_timer(0.5).timeout
		is_falling = true
		await get_tree().create_timer(2).timeout
		is_falling = false
		falling_speed = 0
		set_collision_layer_value(1,false)
		await get_tree().create_timer(0.1).timeout
		position = starting_point
		animated_sprite_2d.play("normal")
		set_collision_layer_value(1,true)

