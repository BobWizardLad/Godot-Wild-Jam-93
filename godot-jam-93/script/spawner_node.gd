class_name SpawnerNode
extends Node2D

# spawn a handed-in unit
# enable or disable

@onready var on_screen_notifier: VisibleOnScreenNotifier2D = $OnScreenNotifier

@export var points_on_kill: int = 20

func _ready() -> void:
	add_to_group("Spawner", true)

## Spawns a specified enemy at the spawner node's position
## Sets the unit's position to here, and give unit the player as a target
func spawn_unit(unit: PackedScene, speed_scale: float, damage_scale: float, health_scale: float):
	assert(unit.instantiate() is Enemy, "Spawner Node " + str(self) + ": PackedScene was not Enemy")
	var inst_unit : Enemy = unit.instantiate()
	inst_unit.global_position = global_position
	inst_unit.damage *= damage_scale
	inst_unit.SPEED *= speed_scale
	inst_unit.max_health *= health_scale
	inst_unit.current_health = inst_unit.max_health
	inst_unit.nav_target = get_tree().get_first_node_in_group("Player")
	inst_unit.died.connect(get_tree().get_first_node_in_group("EndlessGameManager").update_points.bind(points_on_kill)) # TODO Point per kill
	inst_unit.pickup_holder_died.connect(get_tree().get_first_node_in_group("PickupSpawner").spawn_pickup)
	get_parent().add_child(inst_unit)

## Checks to see if the player is nearby, to help prevent 'ambush' spawns
func is_onscreen():
	return on_screen_notifier.is_on_screen()
