class_name BulletArea
extends DamageArea

## Memory if this bullet has dealt damage before
var has_collided: bool = false
signal bullet_area_has_collided

## Bullets will remember that they have caused damage and will stop dealing damage
func handle_detected_body_or_area(collided_node: CollisionObject2D):
	## Collide and disable
	if collided_node is Unit && !has_collided:
		bullet_area_has_collided.emit() # Notify any modifiers that this bullet has collided
		attacked_body.emit(collided_node) # Notify attack instance
		collided_node.take_damage(damage, self, is_heavy_strike)
		has_collided = true
	else:
		return
