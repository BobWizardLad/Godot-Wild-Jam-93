extends Node

@export var pickups_pool : Array[PackedScene]
## Percentage chance a pickup will be spawned
@export_range(0.0, 1.0) var pickup_chance: float

func spawn_pickup(pickup_position: Vector2) -> void:
	var roll = randf()
	if roll <= pickup_chance:
		var pickup : Area2D = pickups_pool[randi_range(0, pickups_pool.size()-1)].instantiate()
		pickup.global_position = pickup_position
		get_tree().current_scene.add_child(pickup)
