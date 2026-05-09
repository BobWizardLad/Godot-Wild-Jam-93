class_name DamageArea
extends Area2D

signal attacked_body(body: Node2D)

@export var damage: int
@export var is_heavy_strike: bool

func _physics_process(delta: float) -> void:
	if has_overlapping_bodies():
		var body = get_overlapping_bodies()[0]
		handle_detected_body_or_area(body)
	elif has_overlapping_areas():
		var area = get_overlapping_areas()[0]
		handle_detected_body_or_area(area)

## Default behavior for any damagearea's collision handling.
func handle_detected_body_or_area(collided_node: CollisionObject2D):
	print_debug("Collision occoured") 
