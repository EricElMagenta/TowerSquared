extends Area2D

@export var energy : int 
var timed_platform : Node

func _ready():
    timed_platform = get_tree().get_first_node_in_group("TimedPlatform")
    $AnimatedSprite2D.play(str(energy)) 

func _on_body_entered(body:Node2D):
    if body is Player:
        AudioManager.play_get_floor()
        timed_platform.add_time(energy)
        queue_free()    
