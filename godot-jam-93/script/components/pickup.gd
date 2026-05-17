@abstract class_name Pickup
extends Area2D
## Class that represents some object that can be picked up by the player.

var picked: bool = false

func _ready() -> void:
	assert($PickupPlayer != null, "No PickupPlayer Audioplayer in children!")

func _physics_process(delta: float) -> void:
	if has_overlapping_bodies() and !picked:
		for body in get_overlapping_bodies():
			if body is Player:
				picked = true
				hide()
				$PickupPlayer.play()
				handle_detected_body(body)
				$PickupPlayer.finished.connect(queue_free)

@abstract func handle_detected_body(body: Player)
