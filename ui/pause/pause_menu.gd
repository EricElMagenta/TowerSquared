extends Control

@onready var menu_container = $MenuContainer

# SETTER
var is_paused:bool = false:
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		menu_container.visible = is_paused
	
########################## FUNCIÓN PRINCIPAL ##############################
func _unhandled_input(event:InputEvent) -> void:
	if event.is_action_pressed("pause"):
		is_paused = !is_paused

########################## FUNCIONES AUXILIARES ##############################
func _on_resume_button_pressed():
	is_paused = false

func _on_exit_level_button_pressed():
	get_tree().quit()

func _on_pause_button_pressed():
	is_paused = !is_paused
