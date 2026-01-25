extends Area2D

enum DIRECTION{
    HORIZONTAL,
    VERTICAL
}

@export var selected_direction = DIRECTION.HORIZONTAL
@export var wind_force:int

func _on_body_entered(body:Node2D):
    if body is Player: 
        match selected_direction:
            HORIZONTAL: body.apply_wind_horizontal(wind_force)
            VERTICAL: body.apply_wind_vertical(wind_force)


func _on_body_exited(body:Node2D):
    if body is Player: 
        match selected_direction:
            HORIZONTAL: body.disable_wind_horizontal()
            VERTICAL: body.disable_wind_vertical()


func _on_area_exited(area:Area2D):
    if area is WindSprite: area.queue_free()
