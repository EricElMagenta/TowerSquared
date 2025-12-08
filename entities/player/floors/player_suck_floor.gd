extends Floor

@onready var suck_area = $SuckArea
@onready var animated_sprite_2d = $AnimatedSprite2D

var sucked_bubble:Area2D
const BUBBLE_OFFSET = 40

func _ready():
	animated_sprite_2d.play("idle")
	player.change_direction.connect(change_direction)
	player.action.connect(suck_bubble)
	player.stop_action.connect(unsuck_bubble)

func _process(_delta):
	if !is_instance_valid(sucked_bubble):
		animated_sprite_2d.play("idle")

func change_direction():
	if scale.x != player.dir: 
		position.x += 24 * player.dir
		scale.x = player.dir

# SUCCIONA BURBUJAS
func suck_bubble() -> void:
	for area in suck_area.get_overlapping_areas():
		if !sucked_bubble &&  area.name.to_lower() == "SuckeableArea".to_lower():
			sucked_bubble = area.get_parent()
			sucked_bubble.get_sucked(self)
			animated_sprite_2d.play("suck")
			AudioManager.play_grab_object()
			return
		
		else: 
			AudioManager.play_inavlid_action()
			return

func unsuck_bubble() -> void:
	if is_instance_valid(sucked_bubble):
		sucked_bubble.get_unsucked(self)
		sucked_bubble = null
		animated_sprite_2d.play("idle")
		AudioManager.play_drop_object()
		
	else: 
		AudioManager.play_inavlid_action()
