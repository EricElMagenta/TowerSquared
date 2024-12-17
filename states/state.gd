extends Node
class_name State

# Se llama a la señal cada vez que cambiamos de state
signal state_transition

# Métodos básic de la state machine
# Cambiar de un state a otro
func Enter():
	pass

# Salir del state actual	
func Exit():
	pass
	
# Actualizar el framerate (el tutorial dice que actualiza los frames visuales)
func Update(_delta: float):
	pass
	
# Actualiza las físicas
func Physics_Update(_delta: float):
	pass
