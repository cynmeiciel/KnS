extends RefCounted
class_name Damage

const UPFORCE: Vector2 = Vector2(1, -1)

var damage: float
var stun_duration: float
var knock_down: bool
var knock_force: Vector2
var recov_accele: float
var statuses: Array[StringName]
var overwhelm: bool
var reversed_direction: bool

func _init(_damage: float = 0, _stun_duration: float = 0.5, _knock_down: bool = false,
	_knock_force: Vector2 = UPFORCE*200, _recov_accele: float = 300,
	_statuses: Array[StringName] = [], _overwhelm: bool = false, _reversed_direction = false):
	self.damage = _damage
	self.stun_duration = _stun_duration
	self.knock_down = _knock_down
	self.knock_force = _knock_force
	self.recov_accele = _recov_accele
	self.statuses = _statuses
	self.overwhelm = _overwhelm
	self.reversed_direction = _reversed_direction
	
