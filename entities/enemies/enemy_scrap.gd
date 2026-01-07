extends Area2D

@export var speed:int = 5
var damage = 1

func _physics_process(_delta):
    position.y += speed 

func _on_body_entered(body:Node2D):
    if body.has_method("get_hit") && body.player_data.current_health > 0:
        body.get_hit(damage)
