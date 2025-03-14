extends Node2D

# SEÑALES
signal level_finished

# NODOS
@onready var sprite_2d = $Sprite2D
@onready var area_2d = $Area2D

func _physics_process(delta):
	for body in area_2d.get_overlapping_bodies():
		if (body is Player && body.is_on_floor()) && sprite_2d.frame == 0:
			body.state_machine.current_state.state_transition.emit(body.state_machine.current_state, "victory")
			area_2d.set_collision_mask_value(2, false)
			await get_tree().create_timer(1.3).timeout
			level_finished.emit() 
