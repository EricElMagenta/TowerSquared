extends RigidBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("idle")

func box_destroyed():
	set_collision_mask_value(2, false)
	animated_sprite_2d.play("destroyed")

func _on_animated_sprite_2d_animation_finished():
	call_deferred("queue_free")
