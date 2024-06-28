extends CharacterBody2D
class_name Player

# This script contains general-use functions that shared with other nodes

@onready var p_anim := $AnimatedSprite2D
@export var p_ctr : PlayerControl = null
@export var enemy : Player

signal take_damamge(dmg: Damage)
enum {
	stun,
	invincible
}

var curr_status: Dictionary = {
	stun: 0,
	invincible: 0
	#...
}

func get_facing_sign() -> int:
	return -1 if p_anim.flip_h else 1

func get_enemy_direction() -> int:
	return -1 if enemy.position.x - position.x < 0 else 1

func toggle_untargetable(to_untr) -> void:
	if to_untr:
		collision_layer = 0b1000
		collision_mask = 0b110
		p_anim.modulate = Color(modulate, 0.3)
	else:
		collision_layer = 0b1
		collision_mask = 0b10111
		p_anim.modulate = Color(modulate, 1)

func blink_to_enemy(marginx: float = 40, marginy: float = 0, scalar: int = 1,
				 max_distance: float = 0, _delay: float = 0, turn_around: bool = true) -> void:
	if _delay != 0:
		%BlinkDelay.start(_delay)
		await %BlinkDelay.timeout
	var destinationx: float = enemy.position.x + marginx*scalar*get_facing_sign()
	if max_distance != 0:
		destinationx = move_toward(position.x, destinationx, max_distance)
	position = Vector2(destinationx, enemy.position.y+marginy)
	if turn_around:
		p_anim.flip_h = not p_anim.flip_h


func dash_to_enemy(marginx: float = 30, scalar: int = 1,
			 max_distance: float = 1000, _delay: float = 0) -> void:
	if max_distance == 0:
		return
	if _delay != 0:
		%BlinkDelay.start(_delay)
		await %BlinkDelay.timeout
	var destinationx: float = enemy.position.x - marginx*scalar*get_facing_sign()
	destinationx = move_toward(position.x, destinationx, max_distance*get_enemy_direction()*get_facing_sign())
	position = Vector2(destinationx, position.y)


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
