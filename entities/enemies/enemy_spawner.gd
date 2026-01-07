extends Area2D

# NODOS
@export var enemy:PackedScene
@onready var spawn_timer = $SpawnTimer

# VARIABLES
@export var time:int
@export var enemy_speed:int
@export var enemy_direction:int

##################################### FUNCIONES  ###############################
func _ready():
    spawn_timer.wait_time = time

func spawn_enemy():
    if enemy:
        var enemy_instance = enemy.instantiate()
        enemy_instance.position = position

        if "speed" in enemy_instance: enemy_instance.speed = enemy_speed
        if "dir" in enemy_instance: enemy_instance.dir = enemy_direction
        add_sibling(enemy_instance)
        
    else:
        print("No enemy asigned at spawn")

##################################### SEÑALES  ###############################
func _on_spawn_timer_timeout():
    spawn_enemy()

