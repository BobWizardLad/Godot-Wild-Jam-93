class_name MeleeArea
extends DamageArea

@export var attack_cooldown: Timer

## Melee area will make a detection attempt only when damage is off cooldown
func handle_detected_body_or_area(collided_node: CollisionObject2D):
	## Collide and disable
	if collided_node is Unit && attack_cooldown.is_stopped():
		attacked_body.emit(collided_node) # Notify attack instance
		collided_node.take_damage(damage, self, is_heavy_strike)
		attack_cooldown.start()
	else:
		return
