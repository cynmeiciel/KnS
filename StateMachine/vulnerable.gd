extends State
class_name VulnerableStateP

var dmg: Damage

func _ready() -> void:
	owner.take_damage.connect(take_damage)

func can_enter() -> bool:
	return true

func enter() -> void:
	$VulDuration.start(dmg.stun_duration)
	owner.velocity = dmg.knock_force
	p_anim.flip_h = false if dmg.knock_force.x < 0 else true
	
	super.enter()

func exit() -> void:
	$VulDuration.stop()
	
func update(_delta : float) -> void:
	pass

func handle_input(_ev : InputEvent) -> void:
	pass

func physics_update(_delta : float) -> void:
	owner.velocity.x = move_toward(owner.velocity.x, 0, dmg.recov_accele*_delta)
	owner.velocity.y += gravity*_delta
	owner.move_and_slide()


func take_damage(dm: Damage) -> void:
	dmg = dm

func _on_vul_duration_timeout() -> void:
	if owner.is_on_floor():
		transits_to.emit("Idle")
	else:
		transits_to.emit("Air")
