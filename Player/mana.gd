extends Node
class_name Mana

signal mp_changed(new_mp)

const MP_MAX: int = 1000
var mp: int:
	set(val):
		if mp == val:
			return
		mp = clampi(round(val), 0, 1000)
		$Regen.start(0.5)
		mp_changed.emit(mp)
	get:
		return mp

# Called when the node enters the scene tree for the first time.
func _ready():
	mp = MP_MAX


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#func _unhandled_input(event):
	#if event.is_action_pressed("ui_accept"):
		#mp -= 10
		#print(mp)

func _on_regen_timeout():
	mp += 1
	$Regen.start(0.01)
	if mp == MP_MAX:
		$Regen.stop()
