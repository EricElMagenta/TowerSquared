extends CharacterBody2D

@export var portal:PackedScene

const SPEED = 250

var dir:int
var spawn_pos:Vector2
var state:String

func _ready():
	scale.x = dir
	global_position = spawn_pos

	match state:
		"A": $AnimatedSprite2D.play(state)

		"Z": $AnimatedSprite2D.play(state)

func _physics_process(_delta):
	velocity = Vector2(SPEED*dir, 0)
	move_and_slide()

	if is_on_wall():
		create_portal()
		queue_free()

func create_portal():
	var portal_instance = portal.instantiate()
	portal_instance.portal_type = state
	portal_instance.spawn_pos = global_position

	add_sibling(portal_instance)