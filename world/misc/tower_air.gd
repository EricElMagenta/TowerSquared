extends Area2D

const level_1 := "air_tower_1.tscn"
const level_2 := "air_tower_2.tscn"
const level_3 := "air_tower_3.tscn"
const level_4 := "air_tower_4.tscn"
const level_5 := "air_tower_5.tscn"
const level_6 := "air_tower_6.tscn"
const level_7 := "air_tower_7.tscn"

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
	animated_sprite_2d.play("default")

	# Mostrar niveles seleccionables
	if GameManager.is_level_selectable("airtower", "air_1"): button_level_1.visible = true
	if GameManager.is_level_selectable("airtower", "air_2"): button_level_2.visible = true
	if GameManager.is_level_selectable("airtower", "air_3"): button_level_3.visible = true
	if GameManager.is_level_selectable("airtower", "air_4"): button_level_4.visible = true
	if GameManager.is_level_selectable("airtower", "air_5"): button_level_5.visible = true
	if GameManager.is_level_selectable("airtower", "air_6"): button_level_6.visible = true
	if GameManager.is_level_selectable("airtower", "air_7"): button_level_7.visible = true

	if GameManager.air_tower_clear: $ClearFlag.visible = true

func _process(_delta):
	if $CanvasLayer.visible:
		is_paused = true

func toogle_level_selector():
	$CanvasLayer.visible = true


func is_tower_cleared():
	return GameManager.techno_tower_clear

func go_to_next_zone():
	get_tree().call_deferred("change_scene_to_file", "res://cutscenes/air_tower/air_tower_intro_cutscene.tscn")

func _on_level_1_pressed():
	GameManager.sharked_player = false
	if AudioManager.music.playing: AudioManager.music.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cutscenes/air_tower/air_tower_intro_cutscene.tscn")


func _on_level_2_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/air_tower/air_tower_2.tscn")


func _on_level_3_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/air_tower/air_tower_3.tscn")


func _on_level_4_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/air_tower/air_tower_4.tscn")


func _on_level_5_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/air_tower/air_tower_5.tscn")


func _on_level_6_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/air_tower/air_tower_6.tscn")


func _on_level_7_pressed():
	GameManager.sharked_player = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world/air_tower/air_tower_7.tscn")










