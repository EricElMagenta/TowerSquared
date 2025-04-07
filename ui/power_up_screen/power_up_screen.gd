extends CanvasLayer

# NODOS
@onready var new_floor_texture = %NewFloorTexture
@onready var power_up_label = %PowerUpLabel

# VARIABLES
var new_texture:CompressedTexture2D = null
var parent_power_up: Area2D
var floor_type: String
var floor_showed: bool = false

# SETTER
var is_paused:bool = false:
	set(value):
		is_paused = value
		get_tree().paused = is_paused

# PAUSAR EL JUEGO MIENTRAS SE MUESTRA LA INFORMACIÓN DEL POWER UP
func _process(delta):
#	Muestra el piso solo una vez y pausa el juego
	if visible:
		if !floor_showed: show_new_floor(floor_type)
		is_paused = true
	
#	Quita la pausa y la ventana
	if Input.is_action_just_pressed("next"):
		if parent_power_up: parent_power_up.queue_free()
		is_paused = false

# INICIALIZA LA VENTANA CON LA INFORMACIÓN DEL POWER UP
func init(power_up:Area2D, new_floor_tpye:String):
	parent_power_up = power_up
	floor_type = new_floor_tpye

# MOSTRAR EL PISO ADQUIRIDO
func show_new_floor(new_floor:String):
	new_texture = load("res://assets/power-ups/" + new_floor + ".png")
	new_floor_texture.texture = new_texture
	power_up_label.text = "item_" + floor_type
	floor_showed = true
