extends Node
class_name StateMachine

@onready var label_state = %LabelState
@export var initial_state : State

var current_state : State
var states : Dictionary = {}

# Si encuentra algún estado en "get_children" lo agrega al diccionario
# Se añade una referencia al nodo padre en cada estado.
func init(parent : CharacterBody2D):
	for child in get_children():
		if child is State:
			child.parent = parent
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)

# Revisa si hay un estado inicial y se cambia en caso de existir.			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	label_state.text = current_state.name
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

############################### SEÑALES #######################################
# Primero revisa que la transición sea válida y luego hace el cambio de states
func change_state(prior_state: State, new_state_name : String):
	
	# Revisa que el state anterior sea el mismo que el actual, para consistencia.
	# Se asegura de que el cambio se haga desde el state correcto
	if prior_state != current_state: 
		print("Cambio de states inválido. El state viejo es: " + prior_state.name +
		" pero el actual es " + current_state.name)
		return

	# Se obtiene el nuevo state desde el diccionario y revisa si existe
	var new_state = states.get(new_state_name.to_lower())
	if !new_state: 
		print("El nuevo state está vacío")
		return
	
	# Salimos del state actual y entramos al nuevo
	if current_state: current_state.Exit()
	new_state.Enter()
	current_state = new_state
