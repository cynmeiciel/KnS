class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath()

# The current active state. At the start of the game, we get the `initial_state`.
@onready var curr_state: State = get_node(initial_state)
@onready var atk_node: AttackStateP = $Attack

var states: Dictionary = {}

func _ready():
	await owner.ready
	owner.take_damage.connect(take_damage)
	owner.is_dead.connect(is_dead)
	
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transits_to.connect(transition)
			child.transits_atk.connect(transition_atk) 
	
	curr_state.enter()
	
func _unhandled_input(event):
	curr_state.handle_input(event)

func _process(delta):
	curr_state.update(delta)
	
func _physics_process(delta):
	curr_state.physics_update(delta)

func transition(new_state: String, do_assert: bool = true) -> void:
	if do_assert:
		assert(has_node(new_state), "Does not have %s" % new_state)
		assert(new_state != "Attack", "Can only transition to attack state with the specific transition signal!")
		
	var next: State = get_node(new_state)
	if next.can_enter():
		curr_state.exit()
		curr_state._active = false
		
		curr_state = next
		
		curr_state.enter()
		curr_state._active = true
		transitioned.emit(curr_state.name)

func transition_atk(atk_code: String) -> void:
	assert(atk_code.length() <= 3, "Invalid attack code!")
	atk_node.next_atk = AtkCode.from_string(atk_code)
	if curr_state.name != "Attack":
		transition("Attack", false)
	
	else:
		if curr_state.can_enter():
			curr_state.enter()
			transitioned.emit(curr_state.name)
		#else:
			#transition("Idle")

func take_damage(dmg: Damage) -> void:
	
	if not curr_state is BlockStateP or dmg.overwhelm:
		if dmg.knock_down:
			transition("Knocked")
		else:
			transition("Vulnerable")

func is_dead(_idx: int) -> void:
	$Knocked.alive = false
	transition("Knocked")
	
