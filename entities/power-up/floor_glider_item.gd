extends Area2D

signal got_floor

var floor_type = "player_glider_floor"


func _on_body_entered(body):
    if body is Player:
        got_floor.emit(floor_type)
        queue_free()