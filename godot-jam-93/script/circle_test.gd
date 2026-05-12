extends Node2D

@export var path_orbit: Shape2D

# CIRCLE
func _process(delta: float) -> void:
	$Marker.global_position = get_point_at_angle($Angle.value)

func get_point_at_angle(angle: int):
	return Vector2(position.x + path_orbit.radius * cos(angle), position.y + path_orbit.radius * sin(angle))
