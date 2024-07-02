extends Node
class_name Stamina

signal st_changed(new_st)

const ST_MAX: int = 100
var st: int:
	set(val):
		st = clampi(round(val), 0, 100)
		$RegenDelay.start(1.2)
		st_changed.emit(st)
	get:
		return st

# Called when the node enters the scene tree for the first time.
func _ready():
	st = ST_MAX

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_regen_delay_timeout():
	st += 3
	$RegenDelay.start(0.15)
	if st == ST_MAX:
		$RegenDelay.stop()
