extends Node

@export var debuglayers: Control = null

func has_debug() -> bool:
	return not (debuglayers == null)
