extends State
class_name SuperDashStateP

const BDASHCD : float = 0.3
const BDASHDUR : float = 0.15

const BDASHVEL : float = 1400.0

const BDASHCOST : int = 29

var multiplier: float = 9
#func _ready():
	#$DashDelay.wait_time = BDASHCD
	#$DashDuration.wait_time = BDASHDUR
#
func can_enter() -> bool:
	if %Stamina.st >= BDASHCOST and %DashDelay.is_stopped():
		return true
	else:
		return false
#
func enter() -> void:
	%DashDelay.start(BDASHCD)
	$SuperDashDuration.start(BDASHDUR)
	%Stamina.st -= BDASHCOST
	multiplier = 9
	owner.velocity = Vector2(owner.get_facing_sign() * BDASHVEL, -500)
	
	super.enter()
	#
func exit() -> void:
	owner.velocity.x *= 0.5
	#
	#
func update(_delta : float) -> void:
	if owner.is_on_floor() and $SuperDashDuration.is_stopped():
		transits_to.emit("Idle")
		#
#func handle_input(_ev : InputEvent) -> void:
	#if _ev.is_action_pressed(p_ctr.j):
		#transits_to.emit("Idle")
	
func physics_update(_delta : float) -> void:
	owner.velocity.y += multiplier
	multiplier *= 1.6
	owner.move_and_slide()

