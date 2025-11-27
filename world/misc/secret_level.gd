extends Node2D

@onready var fake_wall = $Objects/FakeWall
@onready var button_1 = $Objects/Button
@onready var button_2 = $Objects/Button2
@onready var button_3 = $Objects/Button3
@onready var player = $Player
@onready var health_container = $CanvasLayer/HealthContainer
@onready var door_stone = $DoorStone
@onready var scene_transition = $SceneTransition

var is_on_shooting_range = false
var open_wahhll_count = 0

func _ready():
	if !AudioManager.music.playing || AudioManager.current_music.to_lower() != "tutorial_tower": AudioManager.change_song("secret_level")
	RenderingServer.set_default_clear_color(Color.BLACK)

	# TRANCISIÓN DEL NIVEL
	scene_transition.new_level_transition()
	await get_tree().create_timer(0.5).timeout

	# VIDA DEL JUGADOR
	health_container.set_max_health(player.player_data.max_health)
	player.health_changed.connect(health_container.update_health)

	button_1.kill_wall.connect(open_wahhll)
	button_2.kill_wall.connect(open_wahhll)
	button_3.kill_wall.connect(open_wahhll)


func open_wahhll():
	open_wahhll_count += 1
	if is_instance_valid(fake_wall) && open_wahhll_count == 3: fake_wall.queue_free()