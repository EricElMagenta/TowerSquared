extends Area2D

enum DIRECTION{
    HORIZONTAL,
    VERTICAL
}

const HORIZONTAL_ORIENTATION = 0
const VERTICAL_ORIENTATION = 90

@export var selected_direction = DIRECTION.HORIZONTAL
@export var wind_sprite:PackedScene
@export var up_limit:int = 15
@export var down_limit:int = 15
@export var dir:int = 1

var speed = 10

func _ready(): 
    match selected_direction:
        HORIZONTAL: rotation_degrees = HORIZONTAL_ORIENTATION
        VERTICAL: rotation_degrees = VERTICAL_ORIENTATION

func _on_timer_timeout():
    var wind_sprite_instance = wind_sprite.instantiate()
    wind_sprite_instance.dir = dir
    wind_sprite_instance.speed = speed
    wind_sprite_instance.position.y = randi_range(up_limit, -down_limit)
    add_child(wind_sprite_instance)