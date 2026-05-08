extends DamageArea

func on_body_entered(body: Node2D):
	if body is Unit && !(body is Player):
		attacked_body.emit(body)
		body.take_damage(damage, self, is_heavy_strike)
	else:
		return
