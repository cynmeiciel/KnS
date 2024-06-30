extends State
class_name AttackStateP

const ATK_STCOST: Array[int] = [4, 9]
@export var CharAtkInfo: Resource  # MP costs also stored here

# Attack code format: <key><?key?><sequence>
# For example: g2 means the action when 'g' is performed twice
var curr_atk: AtkCode = AtkCode.new("", "", 0)
# This only stores the <key> pressed
var next_atk: AtkCode = AtkCode.new("", "", 0)

# Whether the player can interrupt the state with another input
var can_break: bool = false

func get_atk_key(full: bool = true, atk: AtkCode = curr_atk) -> String:
	if full:
		return atk.modifier + atk.key
	else:
		return atk.key

# Also fill in 'curr_atk' if it returns true
func is_next_atk_valid() -> bool:
	if curr_atk.key.is_empty():
		curr_atk = next_atk
		curr_atk.to_next_seq()
		return true
	
	if curr_atk.same_key(next_atk):
		curr_atk.to_next_seq()
		return true
	
	if next_atk.to_str() in CharAtkInfo.SEQ[curr_atk.to_str()]:
		curr_atk = next_atk
		pass #TODO

	return true

func is_enough_cost() -> bool:
	var cost = get_cost()
	return %Mana.mp >= cost["mp"] and %Stamina.st >= cost["st"]
	
func get_cost(atk: AtkCode = next_atk) -> Dictionary:
	match get_atk_key(false, atk):
		'g':
			return create_cost(ATK_STCOST[0], 0)
		'h':
			return create_cost(ATK_STCOST[1], 0)
		_:
			return create_cost(0, 0)

func create_cost(st = 0, mp = 0) -> Dictionary:
	return {"st": st, "mp": mp}

func can_enter() -> bool:
	return is_next_atk_valid() and is_enough_cost()

func enter() -> void:
	owner.velocity = Vector2.ZERO
	
	print("Transitioned to %s %s" % [self.name, curr_atk.to_str(true)])
	p_anim.play("_a_%s" % curr_atk.to_str(true))
	%Mana.mp -= get_cost()["mp"]
	%Stamina.st -= get_cost()["st"]

func exit() -> void:
	curr_atk.clear()
	next_atk.clear()

func update(_delta : float) -> void:
	pass

func handle_input(_ev : InputEvent) -> void:
	if not $AttackWait.is_stopped():
		if _ev.is_action_pressed(p_ctr.g):
			transits_atk.emit("g")

func physics_update(_delta : float) -> void:
	pass

func _on_animated_sprite_2d_animation_finished():
	$AttackWait.start(0.25)

func _on_animated_sprite_2d_animation_changed():
	$AttackWait.stop()

func _on_attack_wait_timeout():
	if _active:
		transits_to.emit("Idle")

