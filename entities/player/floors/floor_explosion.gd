extends AnimatedSprite2D

func _ready():
	play("floor_explosion")

func _on_animation_finished():
	queue_free()
