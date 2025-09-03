extends Enemy

# VARIABLES
@export var speed := 200
@export var damage := 1
@export var attack_frequency := 3
@export var jump_force := 300

var dir := 1
var is_attacking := false
var initial_height
var ded := false

const GRAVITY = 9.8
const SHARK_GO_UP_DEGREES = -90
const SHARK_GO_DOWN_DEGREES = -270
const SHARK_LOOK_RIGHT_DEGREES = 0
const SHARK_LOOK_LEFT_DEGREES = 180
const NO_VERTICAL_MOVEMENT = 0

# NODOS
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var shark_timer = $SharkTimer

# El tiburon no nada, sino que se mantiene a la altura en la que se instancia y salta para atacar.
# Cuando regresa a su altura inicial vuelve a "nadar". La gravedad solo le afecta cuando ataca.
###################################### FUNCIONES PRINCIPALES ###############################
func _ready():
	animated_sprite_2d.play("swim")
	shark_timer.wait_time = attack_frequency
	initial_height = position.y
	shark_timer.start()

func _physics_process(_delta):
	handle_gravity()

	if !is_attacking: swim()
	if is_attacking && velocity.y > 0: attack_going_down()
	if initial_height - position.y < 0: go_back_swimming()
	if ded: velocity = Vector2.ZERO

	hit_player()
	move_and_slide()

##################################### FUNCIONES AUXILIARES ###############################
func swim():
	if is_on_wall(): handle_collisions()
	velocity.x = speed * dir

func go_back_swimming():
		set_collision_mask_value(1, true)
		velocity.y = NO_VERTICAL_MOVEMENT

		if dir == 1: rotation_degrees = SHARK_LOOK_RIGHT_DEGREES
		elif dir == -1: rotation_degrees = SHARK_LOOK_LEFT_DEGREES

		is_attacking = false
		animated_sprite_2d.play("swim")
	
func handle_gravity():
	if !is_attacking: position.y = initial_height
	else: velocity.y += GRAVITY

func handle_collisions():
	scale.x *= -1 
	dir *= -1

func attack_going_up():
	set_collision_mask_value(1, false)
	is_attacking = true
	animated_sprite_2d.play("attack")
	velocity.y = -jump_force
	velocity.x = 0
	rotation_degrees = SHARK_GO_UP_DEGREES
	
func attack_going_down():
	rotation_degrees = SHARK_GO_DOWN_DEGREES

func hit_player():
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("get_hit") && body.player_data.current_health > 0:
			body.get_hit(damage)

func get_destroyed():
	ded = true
	hitbox.set_collision_mask_value(2, false)
	hitbox.set_collision_mask_value(5, false)
	animated_sprite_2d.play("explode")
	AudioManager.play_explosion()
	await get_tree().create_timer(0.4).timeout
	AudioManager.play_box_explode()

#################################### SEÑALES ###############################
func _on_shark_timer_timeout():
	shark_timer.start()
	attack_going_up()


func _on_animated_sprite_2d_animation_finished():
	queue_free()
