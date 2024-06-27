class_name State
extends Node

# Emit to transition to the new state
signal transits_to(new_state)

var p_anim : AnimatedSprite2D
var p_ctr : PlayerControl

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
