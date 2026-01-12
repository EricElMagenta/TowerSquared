extends Area2D

@export var new_speed:int
@export var exit_speed:int

var my_platform:Node2D

func _ready():
    my_platform = get_tree().get_first_node_in_group("TimedPlatform")

func _on_body_entered(body:Node2D):
    if body is AnimatableBody2D:
        my_platform.update_speed(new_speed)


func _on_body_exited(body):
    if body is AnimatableBody2D:
        my_platform.update_speed(exit_speed)
