extends CharacterBody2D

@export var speed:int
@export var dir:int
var damage = 3


func _ready():
    scale.x = dir


func _physics_process(delta):
    velocity.x = speed * dir

    if not is_on_floor():
        velocity += get_gravity() * delta
    move_and_slide()


func _on_hitbox_body_entered(body:Node2D):
    if body.has_method("get_hit") && body.player_data.current_health > 0:
        body.get_hit(damage)
