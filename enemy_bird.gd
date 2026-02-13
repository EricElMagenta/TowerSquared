extends CharacterBody2D

const FLYING_SPEED = 120
const ELEVATION_FORCE = -20

@export var dir := 1
var speed := 0
var damage := 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var player_detect_area = $PlayerDetectArea

func _physics_process(_delta):
	velocity.x = speed * dir
	move_and_slide()

func get_destroyed():
	speed = 0
	hitbox.set_collision_mask_value(2, false)
	hitbox.set_collision_mask_value(5, false)
	AudioManager.play_explosion()
	animated_sprite_2d.play("explode")

func get_eaten():
	get_destroyed()

func fly_at_player():
	animated_sprite_2d.play("flying")
	velocity.y = ELEVATION_FORCE
	speed = FLYING_SPEED

func _on_area_2d_body_entered(body:Node2D):
	if body.has_method("get_hit"): body.get_hit(damage)


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "explode": queue_free()

func _on_player_detect_area_body_entered(body:Node2D):
	if body is Player: fly_at_player()
