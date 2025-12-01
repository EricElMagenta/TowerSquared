extends Area2D

const level_1 := "tutorial_1.tscn"
const level_2 := "tutorial_2.tscn"
const level_3 := "tutorial_3.tscn"
const level_4 := "tutorial_4.tscn"
const level_5 := "tutorial_5.tscn"

var is_paused:bool = false:
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		self.visible = is_paused

func _process(_delta):
	if $CanvasLayer.visible:
		is_paused = true

func go_to_next_zone():
	AudioManager.music.stop()
	get_tree().call_deferred("change_scene_to_file", "res://cutscenes/tutorial_tower/tutorial_intro_cutscene.tscn")

func is_tower_cleared():
	return GameManager.tutorial_tower_clear

func toogle_level_selector():
	$CanvasLayer.visible = true

func _on_level_1_pressed():
	GameManager.sharked_player = false
	if AudioManager.music.playing: AudioManager.music.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cutscenes/tutorial_tower/tutorial_intro_cutscene.tscn")

func _on_level_2_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/tutorial/"+level_2)

func _on_level_3_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/tutorial/"+level_3)

func _on_level_4_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/tutorial/"+level_4)

func _on_level_5_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/tutorial/"+level_5)