extends Node
## Pool of possible pickups
@export var pickups_pool : Array[PackedScene]
## Chance of each pickup type being spawned
## MUST be a float between 0.0 and 1.0.
## Spawns are decided by subtracting the spawn chance from the rolled
## percentile. If the sum of your spawn chance pool  is > 1.0, then anything after
## 1.0 as the list is summed will not have a chance of spawning
@export var spawn_chance: Array[float]

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

## Decides what randomized spawn will occour
## Spawns are decided by subtracting the spawn chance from the rolled
## percentile. If the sum of your spawn chance pool  is > 1.0, then anything after
## 1.0 as the list is summed will not have a chance of spawning
## Spawns the first enemy in the pool if odds do not add up to 1.0
func get_spawn_from_pool() -> PackedScene:
	var percentile: float = randf_range(0.0, 1.0)
	for each in range(0, pickups_pool.size()):
		percentile -= spawn_chance[each]
		if percentile <= 0.0:
			return pickups_pool[each]
	return pickups_pool[0] # Return the first option if we do not reach a conclusion
