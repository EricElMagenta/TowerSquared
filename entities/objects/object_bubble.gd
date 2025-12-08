extends Area2D
class_name Bubble

# VARIABLES
@export var bounce_multiplier := 1
@export var independent := false
@export var up_speed := 1

var sucked_by: Floor = null
var sucked = false
var spawn_pos : Vector2

##################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	if !independent: global_position = spawn_pos
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	if !sucked:
		if !independent:
			visible = true
			position.y -= up_speed
			position.x += sin(Time.get_ticks_msec()*delta*0.5)
		
		elif independent:
			visible = true
	
	elif sucked && is_instance_valid(sucked_by):
		visible = false
		get_carried(sucked_by)

##################################### FUNCIONES AUXILIARES ###############################
# Hacer rebotar al jugador
func make_player_bounce() -> float:
	return bounce_multiplier

# Ser chupada por el jugador
func get_sucked(sucker:Floor) -> void:
	sucked = true
	sucked_by = sucker

# Ser escupida por el jugador
func get_unsucked(sucker:Floor) -> void:
	var bubble_position_offset = Vector2(sucker.BUBBLE_OFFSET * sucker.player.dir, 0)
	sucked = false
	sucked_by = null
	global_position = sucker.global_position + bubble_position_offset

# Ser llevada por el jugador 
func get_carried(sucker:Floor) -> void:
	var bubble_position_offset = Vector2(sucker.BUBBLE_OFFSET * sucker.player.dir, 0)
	global_position = sucker.global_position + bubble_position_offset

# Reventar burbuja
func get_popped():
	if !sucked:	queue_free()
