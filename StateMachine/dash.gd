extends State
class_name DashStateP

const DASHCD : float = 0.4

func _ready():
	$DashCooldown.wait_time = DASHCD

#func enter() -> void:
	#print_debug("Transitioned to Block")
	#p_anim.play("block")
	
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	pass
		
#func handle_input(_ev : InputEvent) -> void:
	#pass
	
#func physics_update(_delta : float) -> void:
	#pass
