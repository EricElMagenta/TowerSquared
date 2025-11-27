extends PanelContainer

const level_1 := "tutorial_1.tscn"
const level_2 := "tutorial_2.tscn"
const level_3 := "tutorial_3.tscn"
const level_4 := "tutorial_4.tscn"
const level_5 := "tutorial_5.tscn"

func _on_level_1_pressed():
	if AudioManager.music.playing: AudioManager.music.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cutscenes/tutorial_tower/tutorial_intro_cutscene.tscn") 

func _on_level_2_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/tutorial/"+level_2) 

func _on_level_3_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/tutorial/"+level_3) 

func _on_level_4_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/tutorial/"+level_4) 

func _on_level_5_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/tutorial/"+level_5) 
