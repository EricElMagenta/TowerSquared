extends Control

func _on_play_btn_pressed():
	AudioManager.play_dialogue_sound()
	get_tree().change_scene_to_file("res://cutscenes/game_intro/game_intro.tscn")

func _on_lang_btn_pressed():
	AudioManager.play_dialogue_sound()
	if TranslationServer.get_locale() == "es": TranslationServer.set_locale("en")
	elif TranslationServer.get_locale() == "en": TranslationServer.set_locale("es")

func _on_credits_btn_pressed():
	AudioManager.play_dialogue_sound()

func _on_exit_btn_pressed():
	AudioManager.play_dialogue_sound()
	get_tree().quit()

