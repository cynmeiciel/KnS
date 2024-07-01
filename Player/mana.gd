extends Node
class_name Mana

signal mp_changed(new_mp)

const MP_MAX: float = 1000
var mp: float:
	set(val):
		if mp == val:
			return
		mp = clamp(val, 0, 1000)
		mp_changed.emit(mp)
	get:
		return mp

# Called when the node enters the scene tree for the first time.
func _ready():
	mp = 0

func _physics_process(_delta):
	mp += 0.2/((mp/1.5+1)*_delta)

#func _unhandled_input(event):
	#if event.is_action_pressed("ui_accept"):
		#mp -= 10
		#print(mp)

