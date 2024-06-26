extends Label

@onready var state_machine_player := $"../../StateMachine"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = state_machine_player.curr_state.name
