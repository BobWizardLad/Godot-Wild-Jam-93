extends Node

@onready var label_template: PackedScene = load("res://godot-jam-93/components/notifer_label.tscn")

# Spawn an emphasized damage inidcator at the passed in location with the passed in number
func spawn_notifier(position: Vector2, value: String) -> void:
	var notifier: Label = label_template.instantiate()
	notifier.global_position = position
	notifier.text = value
	
	get_tree().current_scene.add_child(notifier)
