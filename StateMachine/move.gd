extends State
class_name MoveStateP

#func enter() -> void:
	#print_debug("Transitioned to Move")
	#p_anim.play("move")
	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	if not owner.is_on_floor():
		transits_to.emit("Air")
		return
		
	var direction = Input.get_axis(p_ctr.a, p_ctr.d)
	if is_zero_approx(direction):
		transits_to.emit("Idle")
	
func handle_input(ev : InputEvent) -> void:
	if ev.is_action_pressed(p_ctr.s):
		transits_to.emit("Block")
		return
	
#func physics_update(_delta : float) -> void:
	#pass
	

