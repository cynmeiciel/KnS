extends State
class_name DashStateP

const DASHCD : float = 0.45
const DASHDUR : float = 0.24

const DASHVEL : float = 900.0

const DASHCOST : int = 17

func _ready():
	$DashDelay.wait_time = DASHCD
	$DashDuration.wait_time = DASHDUR

func can_enter() -> bool:
	return %Stamina.st >= DASHCOST and $DashDelay.is_stopped()

func enter() -> void:
	owner.toggle_untargetable(true)
	$DashDelay.start(DASHCD)
	$DashDuration.start(DASHDUR)
	%Stamina.st -= DASHCOST
	
	super.enter()
	
func exit() -> void:
	owner.toggle_untargetable(false)
	
func update(_delta : float) -> void:
	pass
		
#func handle_input(_ev : InputEvent) -> void:
	#if _ev.is_action_pressed(p_ctr.j):
		#transits_to.emit("Idle")
	
func physics_update(_delta : float) -> void:
	owner.velocity = Vector2(owner.get_facing_sign() * DASHVEL, 0)
	owner.move_and_slide()

func _on_dash_duration_timeout():
	transits_to.emit("Idle")
