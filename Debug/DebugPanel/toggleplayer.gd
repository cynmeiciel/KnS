extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		owner.p = owner.P2
	else:
		owner.p = owner.P1
