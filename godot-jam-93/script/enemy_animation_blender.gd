extends AnimationBlender

## Updates the blend position variable for all animation states.
## updates animation state conditionals to configure the animation state machine
func update_animation_parameters(enemy: Enemy):
	animation_tree["parameters/Walk/blend_position"] = enemy.direction.x
