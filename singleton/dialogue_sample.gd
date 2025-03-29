extends Control

var dialogue_dict = {}

func _ready():
	import_resources_data()

func import_resources_data():
	# Lee el CSV
	var file = FileAccess.open("res://sample.csv", FileAccess.READ)
	
	while !file.eof_reached():
		# Obtiene cada fila del CSV hasta el eof.
		var data_set = file.get_csv_line()
		
		# Guarda los datos en el diccionario en formato {key:value}
		dialogue_dict[dialogue_dict.size()] = data_set

	file.close()
