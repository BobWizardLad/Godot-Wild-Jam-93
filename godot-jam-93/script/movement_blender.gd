extends AnimationBlender

@export var soft_animation_player: AnimationPlayer

## Updates the blend position variable for all animation states.
## updates animation state conditionals to configure the animation state machine
func update_animation_parameters(player: Player):
	var idle: bool = player.velocity == Vector2.ZERO
	var run: bool = player.velocity != Vector2.ZERO
	
	animation_tree.set("parameters/conditions/idling", idle)
	animation_tree.set("parameters/conditions/running", run)
	#animation_tree.set("parameters/conditions/dashing")
	
	animation_tree["parameters/Idle/blend_position"] = player.direction
	animation_tree["parameters/Run/blend_position"] = player.direction
	#animation_tree["parameters/Dash/blend_position"] = player.direction

func animate_damage(_damage: int, heavy_strike: bool = false):
	if soft_animation_player.is_playing():
		soft_animation_player.play("RESET")
		soft_animation_player.queue("damage")
	else:
		soft_animation_player.play("damage")
	if heavy_strike:
		pass # Make an animation tree state change for reeling animation

func animate_dodge():
	if soft_animation_player.is_playing():
		soft_animation_player.play("RESET")
		soft_animation_player.queue("dodge")
	else:
		soft_animation_player.play("dodge")
