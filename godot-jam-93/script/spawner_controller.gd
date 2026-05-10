class_name SpawnerController
extends Node

# manage number of all spawns and spawn attempts
# reference all spawner nodes to make them spawn a unit

## Pool of enemies that can be spawned by this spawn controller
## Enemy class derivatives can be used here
@export var spawn_pool: Array[PackedScene]
## Chance of each enemy type being spawned
## MUST be a float between 0.0 and 1.0.
## Spawns are decided by subtracting the spawn chance from the rolled
## percentile. If the sum of your spawn chance pool  is > 1.0, then anything after
## 1.0 as the list is summed will not have a chance of spawning
@export var spawn_chance: Array[float]

@export var spawn_interval: float

@onready var spawners: Array[SpawnerNode]
@onready  var spawn_interval_timer: Timer = $SpawnIntervalTimer

var wave_spawning: bool = false
var spawns_left: int = 0

signal wave_ended
signal wave_begin

func _ready() -> void:
	# Check to see if the sum of spawn odds are correct (between 1 and 0)
	var spawn_odds_sum: float = 0.0
	for each in spawn_chance:
		spawn_odds_sum += each
	assert(spawn_odds_sum == 1.0, "Spawner Controller Error: Spawn chance pool does not add up to 1.0")
	
	# Connections
	wave_begin.connect(get_tree().get_first_node_in_group("GameStateManager").update_wave_count.bind(1))
	
	# Get all spawners in global group and add them to my references at the end of the first frame
	call_deferred("register_spawners_in_tree")

func _process(_delta: float) -> void:
	if get_tree().get_node_count_in_group("Enemy") == 0:
		wave_ended.emit()
	if wave_spawning and spawns_left > 0 and spawn_interval_timer.is_stopped():
		spawners[randi_range(0, spawners.size()-1)].spawn_unit(get_spawn_from_pool())
		spawns_left -= 1
		spawn_interval_timer.start(spawn_interval)
	elif spawns_left <= 0:
		spawns_left = 0
		wave_spawning = false

func register_spawners_in_tree():
	for each in get_tree().get_nodes_in_group("Spawner"):
		if each is SpawnerNode:
			spawners.append(each)

func start_wave(unit_count: int):
	if get_tree().get_node_count_in_group("Enemy") > 0:
		return
	spawns_left = unit_count
	wave_spawning = true
	wave_begin.emit()

## Decides what randomized spawn will occour
## Spawns are decided by subtracting the spawn chance from the rolled
## percentile. If the sum of your spawn chance pool  is > 1.0, then anything after
## 1.0 as the list is summed will not have a chance of spawning
## Spawns the first enemy in the pool if odds do not add up to 1.0
func get_spawn_from_pool() -> PackedScene:
	var percentile: float = randf_range(0.0, 1.0)
	for each in range(0, spawn_pool.size()):
		percentile -= spawn_chance[each]
		if percentile <= 0.0:
			return spawn_pool[each]
	return spawn_pool[0] # Return the first option if we do not reach a conclusion

func _on_button_pressed() -> void:
	start_wave(8)
