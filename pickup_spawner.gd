extends Node

@export var pickups_pool : Array[PackedScene]
## Percentage chance a pickup will be spawned
@export_range(0.0, 1.0) var pickup_chance: float

func _ready() -> void:
	add_to_group("PickupSpawner", true)

func spawn_pickup(pickup_position: Vector2) -> void:
	var roll = randf()
	if roll <= calculate_pickup_chance(get_tree().get_first_node_in_group("EndlessGameManager").wave_count):
		var pickup : Area2D = pickups_pool[randi_range(0, pickups_pool.size()-1)].instantiate()
		pickup.global_position = pickup_position
		get_tree().current_scene.add_child(pickup)

func calculate_pickup_chance(wave_count: int) -> float:
	return .666 * (1.5/wave_count)
