extends RefCounted
class_name Damage

var damage: int
var stun_duration: float
var knock_down: bool
var knock_force: Vector2
var statuses: Array[StringName]
var overwhelm: bool
var reversed_direction: bool

func _init(_damage: int = 0, _stun_duration: float = 1, _knock_down: bool = false,
	_knock_force: Vector2 = Vector2.ONE, _statuses: Array[StringName] = [], _overwhelm: bool = false,
	_reversed_direction = false):
	self.damage = _damage
	self.stun_duration = _stun_duration
	self.knock_down = _knock_down
	self.knock_force = _knock_force
	self.statuses = _statuses
	self.overwhelm = _overwhelm
	self.reversed_direction = _reversed_direction
	
