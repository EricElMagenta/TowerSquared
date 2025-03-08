extends HBoxContainer

# Precarga los cuadritos de vida
@onready var health_ui_class = preload("res://ui/heart_ui.tscn")

# Crea cuadritos de vida en base a la vida máxima recibida
func set_max_health(max:int):
	for i in range(max):
		var health = health_ui_class.instantiate()
		add_child(health)

func update_health(current_health:int):
	var health = get_children()
	
	for i in range(current_health):
		health[i].update(true)
		
	for i in range(current_health, health.size()):
		health[i].update(false)
