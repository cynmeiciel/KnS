extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (body is Player) and (body.p_ctr.player_index ^ owner.p_ctr.player_index):
		body._take_damage(Damage.new(500, 1.3, true, Vector2(150, -170)))
