extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (body is Player) and (body.p_ctr.player_index ^ get_parent().p_ctr.player_index):
		body._take_damage(Damage.new(40, 1.3, false, Vector2(150, -170), 300, [&"Poison", &"Burn"]))

#func _init(_damage: float = 0, _stun_duration: float = 0.5, _knock_down: bool = false,
	#_knock_force: Vector2 = UPFORCE*200, _recov_accele: float = 300,
	#_statuses: Array[StringName] = [], _overwhelm: bool = false, _reversed_direction = false):
	#self.damage = _damage
	#self.stun_duration = _stun_duration
	#self.knock_down = _knock_down
	#self.knock_force = _knock_force
	#self.recov_accele = _recov_accele
	#self.statuses = _statuses
	#self.overwhelm = _overwhelm
	#self.reversed_direction = _reversed_direction
