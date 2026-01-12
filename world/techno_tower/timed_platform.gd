extends MovingPlatform

# NODOS
@onready var platform_countdown = $AnimatableBody2D/PlatformCountdown 
@onready var platform_timer = $PlatformTimer

# CONSTANTES
const MAX_ENERGY = 9
const EXPLOSION_TIME = 0.16

# VARIABLES
@export var time:int = 5
var remaining_time:int
var has_exploded := false
var countdown_started := false

func _ready():
	path_follow.loop = is_looping
	animated_sprite_2d.play("stop")
	update_timer(time)
	platform_timer.wait_time = time

func _process(_delta):
	remaining_time = int(platform_timer.time_left) % 60
	if countdown_started && !has_exploded: 
		update_timer(remaining_time)

func ded():
	$AnimatableBody2D.set_collision_layer_value(1, false)
	has_exploded = true
	moving = false
	AudioManager.play_explosion()
	platform_countdown.visible = false
	animated_sprite_2d.play("explode")
	await get_tree().create_timer(EXPLOSION_TIME).timeout
	queue_free()


func update_timer(seconds:int):
	platform_countdown.play(str(seconds))


func add_time(energy:int):
	platform_timer.wait_time = platform_timer.time_left
	platform_timer.stop()
	

	if platform_timer.wait_time + energy > MAX_ENERGY: platform_timer.wait_time = MAX_ENERGY
	else: platform_timer.wait_time += energy

	platform_timer.start()
	platform_countdown.play(str(energy))

func update_speed(new_speed:int):
	speed = new_speed

func _on_area_2d_body_entered(body:Node2D):
	if body is Player && !countdown_started:
		countdown_started = true
		moving = true
		platform_timer.start()

func _on_platform_timer_timeout():
	ded()
