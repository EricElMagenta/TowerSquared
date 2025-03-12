extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	stage_transition()

func stage_transition():
	animation_player.play("dissolve")
	await get_tree().create_timer(0.5).timeout
	animation_player.play_backwards("dissolve")
