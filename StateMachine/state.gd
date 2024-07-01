class_name State
extends Node

# Emit to transition to the new state
signal transits_to(new_state)
# Exclusive signal for attack
signal transits_atk(atk_code)

var p_anim : AnimatedSprite2D
var p_ctr : PlayerControl
var p_col : CollisionShape2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _active: bool = false

func get_pending_mod() -> String:
	return get_parent().pending_mod

func get_pending_ult() -> String:
	return get_parent().pending_ult
	
func set_pending_ult(key: String) -> void:
	get_parent().pending_ult = key

func can_enter() -> bool:
	return true

func enter() -> void:
	print("Transitioned to %s" % self.name)
	p_anim.play(self.name.to_lower())

func exit() -> void:
	pass
	
func update(_delta : float) -> void:
	pass

func handle_input(_ev : InputEvent) -> void:
	pass

func physics_update(_delta : float) -> void:
	pass


func handle_atk_input(_ev: InputEvent) -> void:
	for key: String in [p_ctr.g, p_ctr.h, p_ctr.t, p_ctr.y, p_ctr.u]:
		if _ev.is_action(key):
			if key in [p_ctr.g, p_ctr.h]:
				transits_atk.emit(get_pending_mod()+key[0])
			else:
				handle_ult_input(key)
			break


func handle_ult_input(key: String) -> void:
	if key in "tyu":
		var ult := get_pending_ult()
		if ult.is_empty():
			set_pending_ult(key)
			%PendingUlt.start(0.08)
		else: # Perform
			if ult == key: key = ""
			if not owner.is_on_floor(): ult = "a"+ult
			transits_atk.emit(ult+key)
			set_pending_ult("")
					
	else:
		push_error("at handle_ult_input()")
	
	
func _on_pending_timeout_to_perform_ult():
	if _active and get_pending_ult():
		transits_atk.emit(get_pending_mod()+get_pending_ult())
	
	await p_anim.animation_changed
	set_pending_ult("")
		
