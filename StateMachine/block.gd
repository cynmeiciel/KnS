extends OnFloorStateP
class_name BlockStateP

func enter() -> void:
	super.enter()
	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	if not owner.is_on_floor():
		transits_to.emit("Air")
		return
	
	if Input.is_action_just_released(p_ctr.s):
		transits_to.emit("Idle")
		return
	
	super.update(_delta)
	
func handle_input(_ev : InputEvent) -> void:
	pass
	
func physics_update(_delta : float) -> void:
	owner.velocity.x = move_toward(owner.velocity.x, 0, acceleration*_delta)
	direction = get_horizontal_input()
	owner.move_and_slide()
