extends Node
class_name Health

signal hp_changed(new_hp)
signal is_dead()

const HP_MAX: float = 1000
var hp: float:
	set(val):
		hp = clamp(val, 0, 1000)
		hp_changed.emit(hp)
		if hp == 0:
			is_dead.emit()
	get:
		return hp

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = HP_MAX


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		hp -= 10
		print(hp)
		
