class_name State
extends Node

# Emit to transition to the new state
signal transits_to(new_state)

var p_anim : AnimatedSprite2D
var p_ctr : PlayerControl
var p_col : CollisionShape2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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
