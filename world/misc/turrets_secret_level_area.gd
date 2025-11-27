extends Node2D

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_on_range_screen_entered():
	process_mode = Node.PROCESS_MODE_INHERIT
	

func _on_on_range_screen_exited():
	process_mode = Node.PROCESS_MODE_DISABLED