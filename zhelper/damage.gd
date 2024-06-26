extends Resource
class_name Damage

func _init(damage: int = 0, stun_duration: float = 1, 
	knock_force: float = 1, statuses: Array[String] = []):
	self.damage = damage
	self.stun_duration = stun_duration
	self.knock_force = knock_force
	self.statuses = statuses
	
