extends CharacterBody2D
class_name Player

# This script contains general-use functions shared with other nodes

@onready var p_anim := $AnimatedSprite2D
@export var p_ctr : PlayerControl = null
@export var enemy : Player

var invincible: bool = false
signal take_damage(dmg: Damage)
signal is_dead(idx: int)

func get_facing_sign() -> int:
	return -1 if p_anim.flip_h else 1

func get_enemy_direction() -> int:
	return -1 if enemy.position.x - position.x < 0 else 1

func toggle_untargetable(to_untr: bool, absolute: bool = true) -> void:
	if to_untr:
		if absolute:
			collision_layer = 0b1000
			collision_mask = 0b100010
			p_anim.modulate = Color(modulate, 0.3)
		else:
			collision_layer = 0b10000
			collision_mask = 0b100110
	else:
		collision_layer = 0b1
		collision_mask = 0b100111
		p_anim.modulate = Color(modulate, 1)


func blink_to_enemy(marginx: float = 40, marginy: float = 0, scalar: int = 1,
				 max_distance: float = 0, turn_around: bool = true) -> void:
	var destinationx: float = enemy.position.x + marginx*scalar*get_facing_sign()
	if max_distance != 0:
		destinationx = move_toward(position.x, destinationx, max_distance)
	position = Vector2(destinationx, enemy.position.y+marginy)
	if turn_around:
		p_anim.flip_h = not p_anim.flip_h


func dash_to_enemy(marginx: float = 30, scalar: int = 1,
			 max_distance: float = 1000) -> void:
	if max_distance == 0:
		push_error("max_distance cannot be zero!")
		return
	var destinationx: float = enemy.position.x - marginx*scalar*get_facing_sign()
	destinationx = move_toward(position.x, destinationx, max_distance*get_enemy_direction()*get_facing_sign())
	position = Vector2(destinationx, position.y)


func _take_damage(dmg: Damage) -> void:
	if invincible:
		return
	elif $StateMachine.curr_state is BlockStateP:
		dmg.damage /= 10
	take_damage.emit(dmg)

