extends EnemyAnimationBlender

func update_animation_parameters(enemy: Enemy):
	var walk: bool = !enemy.is_windup
	var windup: bool = enemy.is_windup
	
	animation_tree["parameters/Windup/blend_position"] = enemy.direction.x
	
	animation_tree.set("parameters/conditions/walk", walk)
	animation_tree.set("parameters/conditions/windup", windup)
	
	super(enemy)
	
