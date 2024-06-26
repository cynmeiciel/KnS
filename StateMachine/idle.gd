extends State
class_name IdleStateP

#func enter() -> void:
	#print_debug("Transitioned to Idle")
	#p_anim.play("idle")
	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	if not owner.is_on_floor():
		transits_to.emit("Air")
		return
		
	if Input.is_action_pressed(p_ctr.s):
		transits_to.emit("Block")
		return
		
	var direction = Input.get_axis(p_ctr.a, p_ctr.d)
	if direction:
		transits_to.emit("Move")
		return
	
#func handle_input(ev : InputEvent) -> void:
	
#func physics_update(_delta : float) -> void:
	#pass
	

