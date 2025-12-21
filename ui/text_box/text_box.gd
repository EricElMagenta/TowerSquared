extends MarginContainer

# SEÑALES
signal finished_displaying()

# NODOS
@onready var label = $MarginContainer/Label
@onready var letter_display_timer = $LetterDisplayTimer
@onready var exit_prompt = $NinePatchRect/ExitPrompt

# VARIABLES
const MAX_WIDTH = 256 # Textbox no puede tener un ancho mayor a 256 px
var text = ""
var letter_index = 0 # Necesario para mostrar letra por letra
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

func display_text(text_to_display: String):
	label.text = text_to_display
	
	# El texto del label expande al dicho label, por lo que se pueden calcular
	# las dimensiones de la textbox al mostrar el texto.
	label.text = text_to_display
	
	# Se espera a que la textbox se ajuste al tamaño
	await resized
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	# Si el ancho es mayor al permitido, entonces el texto hace un salto de línea.
	# La textbox se ajusta a los saltos de línea, empezando por "x" y luego "y".
	# (Por eso hay dos "await resize" seguidos) 
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized 
		await resized
		custom_minimum_size.y = size.y

	exit_prompt.position.y = size.y + 2
	
	# Posición de la text_box	
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	
	#label.text = ""
	#display_letter()

# MUESTRA LOS CARACTERES UNO POR UNO
func display_letter():
	label.text += text[letter_index]
	letter_index += 1
	
	# Cuando el index alcanza la última posición emitirá la señal de terminado.
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]: 
		"¡", "!", "¿", "?", ".", ",":
			letter_display_timer.start(punctuation_time)
		" ":
			letter_display_timer.start(space_time)
		_:
			letter_display_timer.start(letter_time)

func _on_letter_display_timer_timeout():
	display_letter()
