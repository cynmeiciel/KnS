extends State
class_name AirStateP

func enter() -> void:
	$KeyDelay.start()
	
	super.enter()
	
	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	if owner.is_on_floor():
		transits_to.emit("Idle")
		return
		
func handle_input(_ev : InputEvent) -> void:
	if not $KeyDelay.is_stopped():
		if _ev.is_action_pressed(p_ctr.g):
			print("lool")
	
#func physics_update(_delta : float) -> void:
	#pass
