extends State
class_name BlockStateP

#func enter() -> void:
	#print_debug("Transitioned to Block")
	#p_anim.play("block")
	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	if not owner.is_on_floor():
		transits_to.emit("Air")
		return
	
	if Input.is_action_just_released(owner.p_ctr.s):
		transits_to.emit("Idle")
		return
		
#func handle_input(_ev : InputEvent) -> void:
	#pass
	
#func physics_update(_delta : float) -> void:
	#pass
