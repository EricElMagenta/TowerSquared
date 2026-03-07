extends Area2D

#CONSTANTES
const level_1 := "end_tower_1.tscn"
const level_2 := "end_tower_2.tscn"
const level_3 := "end_tower_3.tscn"
const level_4 := "end_tower_4.tscn"
const level_5 := "end_tower_5.tscn"
const level_6 := "end_tower_6.tscn"
const level_7 := "end_tower_7.tscn"
const level_8 := "end_tower_8.tscn"
const level_9 := "end_tower_9.tscn"
const level_10 := "end_tower_10.tscn"

#NODOS
@onready var marker_2d = $Marker2D

@onready var button_level_1 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level1
@onready var button_level_2 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level2
@onready var button_level_3 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level3
@onready var button_level_4 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level4
@onready var button_level_5 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level5
@onready var button_level_6 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level6
@onready var button_level_7 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level7
@onready var button_level_8 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level8
@onready var button_level_9 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level9
@onready var button_level_10 = $CanvasLayer/LevelSelectorSea/MarginContainer/VBoxContainer/HBoxContainer/Level10



func _ready():
    # Mostrar niveles seleccionables
    if GameManager.is_level_selectable("endtower", "end_1"): button_level_1.visible = true
    if GameManager.is_level_selectable("endtower", "end_2"): button_level_2.visible = true
    if GameManager.is_level_selectable("endtower", "end_3"): button_level_3.visible = true
    if GameManager.is_level_selectable("endtower", "end_4"): button_level_4.visible = true
    if GameManager.is_level_selectable("endtower", "end_5"): button_level_5.visible = true
    if GameManager.is_level_selectable("endtower", "end_6"): button_level_6.visible = true
    if GameManager.is_level_selectable("endtower", "end_7"): button_level_7.visible = true
    if GameManager.is_level_selectable("endtower", "end_8"): button_level_8.visible = true
    if GameManager.is_level_selectable("endtower", "end_9"): button_level_9.visible = true
    if GameManager.is_level_selectable("endtower", "end_10"): button_level_10.visible = true

    if GameManager.is_end_tower_unlocked(): visible = true
    else: visible = false

var is_paused:bool = false:
    set(value):
        is_paused = value
        get_tree().paused = is_paused
        self.visible = is_paused

func _process(_delta):
    if $CanvasLayer.visible:
        is_paused = true

func go_to_next_zone():
    AudioManager.music.stop()
    get_tree().call_deferred("change_scene_to_file", "res://cutscenes/end_tower/end_tower_intro_cutscene.tscn")

func toogle_level_selector():
    $CanvasLayer.visible = true

func _on_level_1_pressed():
    GameManager.sharked_player = false
    if AudioManager.music.playing: AudioManager.music.stop()
    get_tree().paused = false
    get_tree().change_scene_to_file("res://cutscenes/end_tower/end_tower_intro_cutscene.tscn")

func _on_level_2_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_2)

func _on_level_3_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_3)

func _on_level_4_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_4)

func _on_level_5_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_5)

func _on_level_6_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_6)

func _on_level_7_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_7)

func _on_level_8_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_8)

func _on_level_9_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_9)

func _on_level_10_pressed():
    GameManager.sharked_player = false
    get_tree().paused = false
    get_tree().change_scene_to_file("res://world/end_tower/"+level_10)

