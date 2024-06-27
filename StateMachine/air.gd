extends MotionStateP
class_name AirStateP

var can_jump_on_air: bool = true

func enter() -> void:
	$KeyDelay.start()
	
	super.enter()

	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	if owner.is_on_floor():
		if direction:
			transits_to.emit("Move")
		else:
			transits_to.emit("Idle")
		can_jump_on_air = true
		
		return
		
	super.update(_delta)


func handle_input(_ev : InputEvent) -> void:
	if not $KeyDelay.is_stopped():
		if _ev.is_action_pressed(p_ctr.g):
			print("lool")
		
	if _ev.is_action_pressed(p_ctr.w):
		if can_jump_on_air:
			jump()
			can_jump_on_air = false


func physics_update(delta : float) -> void:
	owner.velocity.y += owner.gravity * delta
	
	super.physics_update(delta)
