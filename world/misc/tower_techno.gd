extends Area2D

const level_1 := "techno_tower_1.tscn"
const level_2 := "techno_tower_2.tscn"
const level_3 := "techno_tower_3.tscn"
const level_4 := "techno_tower_4.tscn"
const level_5 := "techno_tower_5.tscn"
const level_6 := "techno_tower_6.tscn"
const level_7 := "techno_tower_7.tscn"

# NODOS
@onready var button_level_1 = $CanvasLayer/LevelSelectorTechno/MarginContainer/VBoxContainer/HBoxContainer/Level1
@onready var button_level_2 = $CanvasLayer/LevelSelectorTechno/MarginContainer/VBoxContainer/HBoxContainer/Level2
@onready var button_level_3 = $CanvasLayer/LevelSelectorTechno/MarginContainer/VBoxContainer/HBoxContainer/Level3
@onready var button_level_4 = $CanvasLayer/LevelSelectorTechno/MarginContainer/VBoxContainer/HBoxContainer/Level4
@onready var button_level_5 = $CanvasLayer/LevelSelectorTechno/MarginContainer/VBoxContainer/HBoxContainer/Level5
@onready var button_level_6 = $CanvasLayer/LevelSelectorTechno/MarginContainer/VBoxContainer/HBoxContainer/Level6
@onready var button_level_7 = $CanvasLayer/LevelSelectorTechno/MarginContainer/VBoxContainer/HBoxContainer/Level7

@onready var animated_sprite_2d = $AnimatedSprite2D

var is_paused:bool = false:
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		self.visible = is_paused

func _ready():
	if !GameManager.techno_tower_clear: animated_sprite_2d.play("default")
	else: animated_sprite_2d.play("cleared")

	# Mostrar niveles seleccionables
	if GameManager.is_level_selectable("technotower", "techno_1"): button_level_1.visible = true
	if GameManager.is_level_selectable("technotower", "techno_2"): button_level_2.visible = true
	if GameManager.is_level_selectable("technotower", "techno_3"): button_level_3.visible = true
	if GameManager.is_level_selectable("technotower", "techno_4"): button_level_4.visible = true
	if GameManager.is_level_selectable("technotower", "techno_5"): button_level_5.visible = true
	if GameManager.is_level_selectable("technotower", "techno_6"): button_level_6.visible = true
	if GameManager.is_level_selectable("technotower", "techno_7"): button_level_7.visible = true

func _process(_delta):
	if $CanvasLayer.visible:
		is_paused = true


func toogle_level_selector():
	$CanvasLayer.visible = true


func is_tower_cleared():
	return GameManager.techno_tower_clear

func go_to_next_zone():
	get_tree().call_deferred("change_scene_to_file", "res://cutscenes/techno_tower/techno_tower_intro_cutscene.tscn")

func _on_level_1_pressed():
	GameManager.sharked_player = false
	if AudioManager.music.playing: AudioManager.music.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cutscenes/techno_tower/techno_tower_intro_cutscene.tscn")

func _on_level_2_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/techno_tower/"+level_2)
	

func _on_level_3_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/techno_tower/"+level_3)

func _on_level_4_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/techno_tower/"+level_4)

func _on_level_5_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/techno_tower/"+level_5)

func _on_level_6_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/techno_tower/"+level_6)

func _on_level_7_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/techno_tower/"+level_7)
