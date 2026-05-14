@abstract class_name Pickup
extends Area2D
## Class that represents some object that can be picked up by the player.

func _physics_process(delta: float) -> void:
	if has_overlapping_bodies():
		var body = get_overlapping_bodies()[0]
		if body is Player:
			handle_detected_body(body)

@abstract func handle_detected_body(body: Player)
