extends RefCounted
class_name AtkCode

var modifier: String
var key: String
var sequence: int

func _init(_modifier: String, _key: String, _sequence: int = 0):
	self.modifier = _modifier
	self.key = _key
	self.sequence = _sequence

static func from_string(code: String, key_only: bool = true) -> AtkCode:
	if key_only:
		match code.length():
			1:
				return AtkCode.new("", code, 0)
			2:
				if code[0] in "asw":
					return AtkCode.new(code[0], code[1], 0)
				else: # tyu
					if code in ["yt", "uy", "ut"]: code = code.reverse()
					return AtkCode.new("", code, 0)
			3:
				if code[1] + code[2] in ["yt", "uy", "ut"]:
					return AtkCode.new(code[0], code[2]+code[1], 0)
				else:
					return AtkCode.new(code[0], code[1]+code[2], 0)
			_:
				assert(false, "Invalid code")
				return AtkCode.new("-1","-1", -1)
	else:
		match code.length():
			2:
				if code[1].is_valid_int():
					return AtkCode.new("", code[0], int(code[1]))
				else:
					return AtkCode.new("", code, 0)
			3:
				return AtkCode.new(code[0], code[1], int(code[2]))
			_:
				assert(false, "Invalid code")
				return AtkCode.new("-1","-1",-1)


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
	
