extends SubAtk

@export_range(0, 1000) var velocityx: float
@export_range(0, 1000) var accele: float

func enter() -> void:
	_active = true
	owner.velocity.x = velocityx*owner.get_facing_sign()

func exit() -> void:
	_active = false
	
func update(_delta : float) -> void:
	pass

func handle_input(_ev : InputEvent) -> void:
	pass

func physics_update(_delta : float) -> void:
	owner.velocity.x = \
		move_toward(owner.velocity.x, 0, accele*_delta)
	owner.move_and_slide()
