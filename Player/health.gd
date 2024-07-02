extends Node
class_name Health

signal hp_changed(num)

const HP_MAX: float = 1000
var hp: float:
	set(val):
		hp_changed.emit(val-hp)
		hp = clamp(val, 0, 1000)
		if hp == 0:
			owner.is_dead.emit(owner.p_ctr.player_index)
	get:
		return hp

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	owner.take_damage.connect(take_damage)
	hp = HP_MAX


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		hp -= 10
		print(hp)
		

func take_damage(dmg: Damage):
	hp -= dmg.damage
