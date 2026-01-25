extends Area2D

@export var lighting:PackedScene

func shoot_lighting():
    AudioManager.play_bullet_shot()
    var lighting_instance = lighting.instantiate()
    lighting_instance.global_position = $Marker2D.position
    add_child(lighting_instance)

func _on_shoot_timer_timeout():
    if lighting: shoot_lighting()
