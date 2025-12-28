extends Control


func _on_back_btn_pressed():
	AudioManager.play_dialogue_sound()
	visible = false
