extends OnFloorStateP
class_name IdleStateP

#func enter() -> void:
	#can_jump = true
	#super.enter()
	
#func exit() -> void:
	#pass
	
func update(_delta: float) -> void:
	if not owner.is_on_floor():
		transits_to.emit("Air")
		return
		
	if Input.is_action_pressed(p_ctr.s):
		transits_to.emit("Block")
		return
		
	if direction:
		transits_to.emit("Move")
		return
		
	super.update(_delta)


#func handle_input(ev : InputEvent) -> void:
	#if ev.is_action_pressed(p_ctr.j):
		#transits_to.emit("Dash")
	#
	#super.handle_input(ev)
	
#func physics_update(_delta : float) -> void:
	#pass
	

