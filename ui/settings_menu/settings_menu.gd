extends Control

@onready var mute_btn = $PanelContainer/MarginContainer/HBoxContainer3/VBoxContainer/HBoxContainer/MuteBtn
@onready var sfx_btn = $PanelContainer/MarginContainer/HBoxContainer3/VBoxContainer/HBoxContainer/SfxBtn
var aux_texture = null
var aux_texture_1 = null

func _ready():
	aux_texture = mute_btn.texture_normal
	aux_texture_1 = sfx_btn.texture_normal
	if AudioManager.mute:
		aux_texture = mute_btn.texture_normal
		mute_btn.texture_normal = mute_btn.texture_pressed
		mute_btn.texture_pressed = aux_texture

	if AudioManager.sfx_muted:
		aux_texture_1 = sfx_btn.texture_normal
		sfx_btn.texture_normal = sfx_btn.texture_pressed
		sfx_btn.texture_pressed = aux_texture_1


func _on_mute_btn_pressed():
	AudioManager.mute_music()


func _on_back_btn_pressed():
	AudioManager.play_dialogue_sound()
	visible = false


func _on_sfx_btn_pressed():
	AudioManager.mute_sfx()


func _on_control_btn_pressed():
	AudioManager.play_dialogue_sound()
	$ControlMenu.visible = true
