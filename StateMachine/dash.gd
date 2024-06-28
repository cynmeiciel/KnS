extends State
class_name DashStateP

const DASHCD : float = 0.45
const DASHDUR : float = 0.24

const DASHVEL : float = 800.0

func _ready():
	$DashDelay.wait_time = DASHCD
	$DashDuration.wait_time = DASHDUR

func enter() -> void:
	p_col.set_deferred("disabled", true)
	$DashDelay.start()
	$DashDuration.start()
	
	super.enter()
	
func exit() -> void:
	p_col.set_deferred("disabled", false)
	
func update(_delta : float) -> void:
	pass
		
func handle_input(_ev : InputEvent) -> void:
	if _ev.is_action_pressed(p_ctr.j):
		transits_to.emit("Idle")
	
func physics_update(_delta : float) -> void:
	owner.velocity = Vector2(owner.get_facing_sign() * DASHVEL, 0)
	owner.move_and_slide()

func _on_dash_duration_timeout():
	transits_to.emit("Idle")
