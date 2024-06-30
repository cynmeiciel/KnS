extends MotionStateP
class_name AirStateP

@export var MAX_AIR_JUMP: int = 1
var remaining_jump: int = MAX_AIR_JUMP

func enter() -> void:
	$KeyDelay.start()
	
	super.enter()

	
#func exit() -> void:
	#pass
	
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
	#if not $KeyDelay.is_stopped():
		#if _ev.is_action_pressed(p_ctr.g):
			#print("lool")
		
	if _ev.is_action_pressed(p_ctr.w):
		if remaining_jump and $AirJumpDelay.is_stopped():
			jump()
			remaining_jump -= 1
		else:
			$JumpTolerance.start()
	
	super.handle_input(_ev)


func physics_update(delta : float) -> void:
	owner.velocity.y += gravity * delta
	
	super.physics_update(delta)
