extends MotionStateP
class_name AirStateP

@export var MAX_AIR_JUMP: int = 1
var remaining_jump: int = MAX_AIR_JUMP

#func enter() -> void:
	#super.enter()

	
func exit() -> void:
	$KeyDelay.stop()
	
func update(_delta : float) -> void:
	if owner.is_on_floor():
		remaining_jump = MAX_AIR_JUMP
		if $JumpTolerance.is_stopped():
			if direction:
				transits_to.emit("Move")
			else:
				transits_to.emit("Idle")
			return
		
		else:
			jump()
		
	super.update(_delta)


func handle_input(_ev : InputEvent) -> void:
	handle_atk_input(_ev) # "a" means "air"
		
	if _ev.is_action_pressed(p_ctr.w):
		if remaining_jump and $AirJumpDelay.is_stopped():
			jump(false)
			remaining_jump -= 1
		else:
			$JumpTolerance.start()
	
	super.handle_input(_ev)


func physics_update(delta : float) -> void:
	owner.velocity.y += gravity * delta
	
	super.physics_update(delta)

func get_pending_mod() -> String:
	return "a" if ($KeyDelay.is_stopped() ) else "w"
