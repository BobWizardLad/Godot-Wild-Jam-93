class_name StrikeArea
extends DamageArea

@export var offset_length: float

var is_striking: bool = false
signal strike_connected(body: Node2D)

## Offsets the StrikeArea to create a strike attempt; callable, meant to be handled by a parent's attack behavior
func start_strike_collision(target_direction: Vector2, my_offset_length: float = offset_length):
	var offset = target_direction.normalized() * my_offset_length
	position = position + offset

## Ends the offset hitbox position; callable, meant to be handled by a parent's attack behavior
func end_strike_collision():
	position = Vector2.ZERO

## Collision is only handled when teh node is in striking mode, or when the attack is active/
## Offset is applied
func handle_detected_body_or_area(collided_node: CollisionObject2D):
	## Collide and disable
	if collided_node is Unit && is_striking:
		strike_connected.emit() # Notify when a strike attempt succeeds
		attacked_body.emit(collided_node) # Notify attack instance
		collided_node.take_damage(damage, self, is_heavy_strike)
	else:
		return
