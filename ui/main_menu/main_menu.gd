extends Control

@onready var credits_panel = $PanelContainer
@onready var exit_credits_panel = $ExitCreditButtons

func _ready():
	if !AudioManager.music.playing || AudioManager.current_music.to_lower() != "menu": AudioManager.change_song("menu")
	TranslationServer.set_locale("en")

func _on_play_btn_pressed():
	AudioManager.play_dialogue_sound()
	get_tree().change_scene_to_file("res://cutscenes/game_intro/game_intro.tscn")

func _on_lang_btn_pressed():
	AudioManager.play_dialogue_sound()
	if TranslationServer.get_locale() == "es": TranslationServer.set_locale("en")
	elif TranslationServer.get_locale() == "en": TranslationServer.set_locale("es")

func _on_credits_btn_pressed():
	exit_credits_panel.visible = true
	credits_panel.visible = true
	AudioManager.play_dialogue_sound()

func _on_exit_btn_pressed():
	AudioManager.play_dialogue_sound()
	get_tree().quit()


func _on_exit_credit_buttons_pressed():
	exit_credits_panel.visible = false
	credits_panel.visible = false