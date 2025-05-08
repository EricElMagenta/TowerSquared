extends Resource
class_name PlayerData

@export var max_health = 3
@export var move_speed  = 200.0
@export var jump_force = -300.0
@export var air_jump_force = -300.0
@export var bounce_power = -400.0 
@export var gravity = 980
@export var accel = 100
@export var friction = 10
@export var arm_strength = 0
@export var push_force = 100
@export var knockback_force = Vector2(40, -300)

var current_health = max_health


# MOVIMIENTO EN AGUA
@export var swim_speed  = 20
@export var sink_speed = 80
@export var fall_in_water_down_hold = 500
@export var swim_up_force = -80.0
@export var impulse = 0
@export var max_propeller_impulse = 1000
