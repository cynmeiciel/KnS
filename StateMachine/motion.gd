extends State
class_name MotionStateP

const VELOCITY := 400.0
const JUMP_VELOCITY := -470.0
const ACCELERATION := VELOCITY*11

var velocity := VELOCITY:
	set(val):
		var ratio: float = val / VELOCITY
		jump_velocity *= ratio
		acceleration *= ratio
		velocity = val

var jump_velocity := JUMP_VELOCITY
var acceleration := ACCELERATION

var direction: float = 0

func jump() -> void:
	owner.velocity.y = jump_velocity

func get_horizontal_input() -> float:
	return Input.get_axis(p_ctr.a, p_ctr.d)

func update_facing() -> void:
	if direction > 0:
		p_anim.flip_h = false
	elif direction < 0:
		p_anim.flip_h = true
		


#func enter() -> void:
	#print_debug("Transitioned to %s" % self.name)
	#p_anim.play(self.name.to_lower())
#
#func exit() -> void:
	#pass
	
func update(_delta : float) -> void:
	update_facing()

#func handle_input(_ev : InputEvent) -> void:
	#pass
#
func physics_update(_delta : float) -> void:
	direction = get_horizontal_input()
	
	if direction:
		owner.velocity.x = move_toward(owner.velocity.x, direction*velocity, acceleration*_delta)
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, acceleration*_delta)

	owner.move_and_slide()
