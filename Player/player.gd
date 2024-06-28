extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -470.0

@onready var p_anim := $AnimatedSprite2D
@export var p_ctr : PlayerControl = null

func get_facing_sign() -> int:
	return -1 if p_anim.flip_h else 1
#
#func _physics_process(_delta):
	#pass
	# Handle jump.
	#if Input.is_action_just_pressed(p_ctr.w) and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#direction = Input.get_axis(p_ctr.a, p_ctr.d)
	#if direction:
		#velocity.x = direction * SPEED
#
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
