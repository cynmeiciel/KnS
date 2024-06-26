extends StateMachine
class_name StateMachinePlayer


func _ready():
	super._ready()
	for state in get_children():
		if state is State:
			state.p_anim = $"../AnimatedSprite2D"
			state.p_ctr = owner.p_ctr
	

func transition(new_state : String) -> void:
	super.transition(new_state)

func _unhandled_input(event):
	# Here we only handle input that can interrupt states, otherwise we let the state node handle it.
	curr_state.handle_input(event)
