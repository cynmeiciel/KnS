extends RefCounted
class_name AtkCode

var modifier: String
var key: String
var sequence: int

func _init(_modifier: String, _key: String, _sequence: int = 0):
	self.modifier = _modifier
	self.key = _key
	self.sequence = _sequence

func to_next_seq() -> void:
	sequence += 1
	
func same_key(atk: AtkCode) -> bool:
	return atk.key == key and atk.modifier == modifier

func to_str(include_seq: bool = false) -> StringName:
	return modifier+key + (str(sequence) if include_seq else "")

func clear() -> void:
	modifier = ""
	key = ""
	sequence = 0
	
