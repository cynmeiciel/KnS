extends MotionStateP
class_name OnFloorStateP

#func enter() -> void:
	#super.enter()
	
#func exit() -> void:
	#pass
	
#func update(_delta : float) -> void:
	#pass
#
func handle_input(_ev : InputEvent) -> void:
	if _ev.is_action_pressed(p_ctr.w):
		jump()
		%AirJumpDelay.start()
	else:
		handle_atk_input(_ev)
	super.handle_input(_ev)
#
#func physics_update(_delta : float) -> void:
	#pass
