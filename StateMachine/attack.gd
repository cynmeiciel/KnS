extends State
class_name AttackStateP

const ATK_STCOST: Array[int] = [4, 9]
@export var CharInfo: Resource  # MP costs also stored here

# Attack code format: <key><?key?><sequence>
# For example: g2 means the action when 'g' is performed twice
var curr_atk: AtkCode = AtkCode.new("", "", 0)
# This only stores the pressed <key>
var next_atk: AtkCode = AtkCode.new("", "", 0)

# Whether the player can interrupt the state with another input
var can_break: bool = false


func get_atk_key(atk: AtkCode = curr_atk, full: bool = true) -> String:
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
		if curr_atk.sequence < CharInfo.MAX_SEQ[curr_atk.to_str()]:
			curr_atk.to_next_seq()
			return true
		else:
			return false
	
	for seq: String in CharInfo.SEQ[curr_atk.to_str(true)]:
		if seq.begins_with(next_atk.to_str()):
			curr_atk = AtkCode.from_string(seq, false)
			return true

	return false


func is_enough_cost() -> bool:
	var cost = get_cost()
	return %Mana.mp >= cost["mp"] and %Stamina.st >= cost["st"]


func get_cost(atk: AtkCode = next_atk) -> Dictionary:
	var key: StringName = get_atk_key(atk, false)
	match key:
		'g':
			return create_cost(ATK_STCOST[0], 0)
		'h':
			return create_cost(ATK_STCOST[1], 0)
		_:
			return create_cost(0, 0)


func create_cost(st = 0, mp = 0) -> Dictionary:
	return {"st": st, "mp": mp}


func can_enter() -> bool:
	if is_enough_cost():
		return is_next_atk_valid()
	return false 


func enter() -> void:
	print("Transitioned to %s %s" % [self.name, curr_atk.to_str(true)])
	p_anim.play("_a_%s" % curr_atk.to_str(true))
	
	owner.velocity = Vector2.ZERO
	$AttackWait.stop()
	%Mana.mp -= get_cost()["mp"]
	%Stamina.st -= get_cost()["st"]
	
	perform(curr_atk)


func exit() -> void:
	curr_atk.clear()
	next_atk.clear()

#func update(_delta : float) -> void:
	#if not $AttackTolerance.is_stopped(): 
		#print($AttackTolerance.time_left)


func handle_input(_ev : InputEvent) -> void:
	if not $AttackWait.is_stopped():
		handle_atk_input(_ev)
	if _ev.is_action_pressed(p_ctr.a):
		transits_to.emit("Idle")


func physics_update(_delta : float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished():
	if _active:
		$AttackWait.start(0.25)


func _on_attack_wait_timeout():
	if _active:
		if owner.is_on_floor():
			transits_to.emit("Idle")
		else:
			transits_to.emit("Air")

#=================PERFORM====================#

func perform(atk: AtkCode) -> void:
	var code: StringName = atk.to_str(true)
	
	match code:
		_:
			pass
		


