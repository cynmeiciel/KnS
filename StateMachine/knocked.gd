extends State
class_name KnockedStateP

var dmg: Damage
var alive: bool = true

func _ready() -> void:
	owner.take_damage.connect(take_damage)

func can_enter() -> bool:
	return true

func enter() -> void:
	owner.toggle_untargetable(true)
	owner.velocity = dmg.knock_force
	p_anim.flip_h = false if dmg.knock_force.x < 0 else true
	super.enter()

func exit() -> void:
	if alive:
		owner.toggle_untargetable(false)
		$KnDuration.stop()
	
func update(_delta : float) -> void:
	if alive:
		if owner.is_on_floor() and $KnDuration.is_stopped():
			$KnDuration.start()

func handle_input(_ev : InputEvent) -> void:
	if alive:
		if _ev.is_action_pressed(p_ctr.j):
			if owner.is_on_floor():
				transits_to.emit("Idle")

func physics_update(_delta : float) -> void:
	owner.velocity.x = move_toward(owner.velocity.x, 0, dmg.recov_accele*_delta)
	owner.velocity.y += gravity*_delta
	owner.move_and_slide()


func take_damage(dm: Damage) -> void:
	dmg = dm

func _on_kn_duration_timeout() -> void:
	transits_to.emit("Idle")
