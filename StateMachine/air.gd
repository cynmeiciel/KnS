extends State
class_name AirStateP

#func enter() -> void:
	#owner.get_node(^"AnimatedSprite2D").play("air")
	#print_debug("Transitioned to Air")
	
	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	if owner.is_on_floor():
		transits_to.emit("Idle")
		return
		
#func handle_input(_ev : InputEvent) -> void:
	#pass
	
#func physics_update(_delta : float) -> void:
	#pass
