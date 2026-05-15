class_name PlayerInventoryTree
extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		get_tree().paused = !get_tree().paused
		visible = !visible
