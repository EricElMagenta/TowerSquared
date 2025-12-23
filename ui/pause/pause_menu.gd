extends Control

@onready var menu_container = $MenuContainer
@onready var exit_btn = $MenuContainer/MarginContainer/GridContainer/HBoxContainer/ExitContainer

# SETTER
var is_paused:bool = false:
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		menu_container.visible = is_paused
	
########################## FUNCIÓN PRINCIPAL ##############################
func _ready():
	if !GameManager.tutorial_tower_clear: exit_btn.visible = false
	else: exit_btn.visible = true

func _unhandled_input(event:InputEvent) -> void:
	if event.is_action_pressed("pause"):
		is_paused = !is_paused

########################## FUNCIONES AUXILIARES ##############################
func _on_resume_button_pressed():
	is_paused = false

func _on_exit_level_button_pressed():
	is_paused = false
	get_tree().change_scene_to_file("res://world/misc/world_map.tscn")

func _on_pause_button_pressed():
	is_paused = !is_paused
