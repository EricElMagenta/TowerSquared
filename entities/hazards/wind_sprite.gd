extends Area2D
class_name WindSprite

var dir:int
var speed:int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	position.x += speed * dir
