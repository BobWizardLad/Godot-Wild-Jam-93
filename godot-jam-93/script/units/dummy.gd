extends Enemy

func take_damage(value: int, source: Node2D = self, heavy_strike: bool = false):
	$AnimationPlayer.play("take_damage")
	if heavy_strike:
			forced_move(-1 * global_position.direction_to(source.global_position), 35.0, 0.3)
