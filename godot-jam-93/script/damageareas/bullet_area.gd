class_name BulletArea
extends DamageArea

## Memory if this bullet has dealt damage before
var has_collided: bool = false
signal bullet_area_has_collided

func _ready() -> void:
	assert(get_parent().damage != null, str(get_parent()) + ": Parent has no damage stat to reference")
	assert(get_parent().is_heavy_strike != null, str(get_parent()) + ": Parent has no is_heavy_strike stat to reference")

## Bullets will remember that they have caused damage and will stop dealing damage
func handle_detected_body_or_area(collided_node: Node):
	## Collide and disable
	if collided_node is Unit && !has_collided:
		bullet_area_has_collided.emit() # Notify any modifiers that this bullet has collided
		attacked_body.emit(collided_node) # Notify attack instance
		GlobalHitIndicator.spawn_notifier(global_position, str(get_parent().damage)) # damage number
		collided_node.take_damage(get_parent().damage, self, get_parent().is_heavy_strike)
		has_collided = true
	else:
		return
