extends Label

@onready var atk_node := $"../../StateMachine/Attack"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = atk_node.curr_atk.to_upper() if atk_node._active else "_"
