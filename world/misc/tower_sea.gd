extends Area2D

const level_1 := "sea_tower_1.tscn"
const level_2 := "sea_tower_2.tscn"
const level_3 := "sea_tower_3.tscn"
const level_4 := "sea_tower_4.tscn"
const level_5 := "sea_tower_5.tscn"
const level_6 := "sea_tower_6.tscn"
const level_7 := "sea_tower_7.tscn"


var is_paused:bool = false:
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		self.visible = is_paused

func _process(_delta):
	if $CanvasLayer.visible:
		is_paused = true

func go_to_next_zone():
	get_tree().call_deferred("change_scene_to_file", "res://cutscenes/sea_tower/sea_tower_intro_cutscene_1.tscn")

func toogle_level_selector():
	$CanvasLayer.visible = true

func is_tower_cleared():
	return GameManager.sea_tower_clear

func _on_level_1_pressed():
	GameManager.sharked_player = false
	if AudioManager.music.playing: AudioManager.music.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cutscenes/sea_tower/sea_tower_intro_cutscene_1.tscn")

func _on_level_2_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/sea_tower/"+level_2)

func _on_level_3_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/sea_tower/"+level_3)

func _on_level_4_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/sea_tower/"+level_4)

func _on_level_5_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/sea_tower/"+level_5)

func _on_level_6_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/sea_tower/"+level_6)

func _on_level_7_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/sea_tower/"+level_7)

