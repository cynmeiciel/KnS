extends OnFloorStateP
class_name MoveStateP

func enter() -> void:
	direction = get_horizontal_input()
	update_facing()
	super.enter()
	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	if not owner.is_on_floor():
		transits_to.emit("Air")
		return
		
	if Input.is_action_pressed(p_ctr.s):
		transits_to.emit("Block")
		return
	
	if is_zero_approx(direction):
		transits_to.emit("Idle")
		return
		
	super.update(_delta)
	
#func handle_input(ev : InputEvent) -> void:
	#super.handle_input(ev)
	
#func physics_update(_delta : float) -> void:
	#pass
	

