extends Area2D

enum MOVEMENT {
	STILL,
	HORIZONTAL,
	VERTICAL,
	CIRCLE
}

@export var selected_movement = MOVEMENT.STILL
@export var portal_id:int 
@export var limit_left := -100
@export var limit_right := 100
@export var limit_up := 100
@export var limit_down := -100
@export var speed := 1.0
@export var radius := 120
@export var damage := 1
@export var reverse := false

var initial_pos : Vector2
var dir := 1
var angle := 0.0

func _ready():
    $AnimatedSprite2D.play("G")
    initial_pos = position


func _physics_process(delta):
    match selected_movement:
        MOVEMENT.STILL:
            position = initial_pos
        
        MOVEMENT.HORIZONTAL: 
            if initial_pos.x - position.x < (limit_right*-1) || initial_pos.x - position.x > (limit_left*-1): dir *= -1
            position.x += dir * speed
        
        MOVEMENT.VERTICAL: 
            if initial_pos.y - position.y > limit_up || initial_pos.y - position.y < limit_down: dir *= -1
            position.y += dir * speed
        
        MOVEMENT.CIRCLE:
            angle += speed * delta
            var x_pos 
            var y_pos 
            
            if reverse:
                x_pos = sin(angle)
                y_pos = cos(angle)
            
            else:
                x_pos = cos(angle)
                y_pos = sin(angle)
            
            position.x = radius * x_pos + initial_pos.x
            position.y = radius * y_pos + initial_pos.y


func _on_animated_sprite_2d_animation_finished():
    $AnimatedSprite2D.play("G_loop")