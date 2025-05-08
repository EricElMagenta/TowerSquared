extends Area2D
class_name Bubble

# VARIABLES
@export var bounce_multiplier : int
var sucked_by: Floor = null
var sucked = false
var spawn_pos : Vector2

const UP_SPEED = 0.5

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	global_position = spawn_pos
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	if !sucked:
		visible = true
		position.y -= UP_SPEED
		position.x += sin(Time.get_ticks_msec()*delta*0.5)
	
	elif sucked && is_instance_valid(sucked_by):
		visible = false
		get_carried(sucked_by)

func make_player_bounce() -> float:
	return bounce_multiplier

func get_sucked(sucker:Floor) -> void:
	sucked = true
	sucked_by = sucker

func get_unsucked(sucker:Floor) -> void:
	var bubble_position_offset = Vector2(sucker.BUBBLE_OFFSET * sucker.player.dir, 0)
	sucked = false
	sucked_by = null
	global_position = sucker.global_position + bubble_position_offset

func get_carried(sucker:Floor) -> void:
	var bubble_position_offset = Vector2(sucker.BUBBLE_OFFSET * sucker.player.dir, 0)
	global_position = sucker.global_position + bubble_position_offset
	
