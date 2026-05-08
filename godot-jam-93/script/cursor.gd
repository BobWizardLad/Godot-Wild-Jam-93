class_name Cursor
extends Node2D

@export_group("Cursor Settings")
@export var lerp_strength: float

# reports its position to its parent when called
# is pretty <3
# returns nearest interactable ??
#  ...

# Follows the mouse's position every frame
func _process(delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position(), lerp_strength)

## Returns the global_position of this cursor
func get_target() -> Vector2:
	return global_position
