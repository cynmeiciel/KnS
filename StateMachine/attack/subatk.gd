class_name SubAtk
extends Node

var p_anim : AnimatedSprite2D
var p_ctr : PlayerControl
var p_col : CollisionShape2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _active: bool = false

var mod: StringName = &""
var seq: int = 0

func enter() -> void:
	_active = true

func exit() -> void:
	_active = false
	
func update(_delta : float) -> void:
	pass

func handle_input(_ev : InputEvent) -> void:
	pass

func physics_update(_delta : float) -> void:
	pass


##==========Template=========#
#func template():
	#match 
