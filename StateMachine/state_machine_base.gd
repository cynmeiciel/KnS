class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath()

# The current active state. At the start of the game, we get the `initial_state`.
@onready var curr_state: State = get_node(initial_state)

var states: Dictionary = {}

func _ready():
	await owner.ready
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transits_to.connect(transition)
	curr_state.enter()
	
func _unhandled_input(event):
	curr_state.handle_input(event)

func _process(delta):
	curr_state.update(delta)
	
func _physics_process(delta):
	curr_state.physics_update(delta)

func transition(new_state: String) -> void:
	if not has_node(new_state):
		print_debug("Does not have %s" % new_state)
		return
		
	var next: State = get_node(new_state)
	if next.can_enter():
		curr_state.exit()
		
		curr_state = next
		
		curr_state.enter()
		transitioned.emit(curr_state.name)
