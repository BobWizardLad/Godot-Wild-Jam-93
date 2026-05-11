class_name SpawnerNode
extends Node2D

# spawn a handed-in unit
# enable or disable

func _ready() -> void:
	add_to_group("Spawner", true)

## Spawns a specified enemy at the spawner node's position
## Sets the unit's position to here, and give unit the player as a target
func spawn_unit(unit: PackedScene):
	assert(unit.instantiate() is Enemy, "Spawner Node " + str(self) + ": PackedScene was not Enemy")
	var inst_unit = unit.instantiate()
	inst_unit.global_position = global_position
	inst_unit.nav_target = get_tree().get_first_node_in_group("Player")
	inst_unit.died.connect(get_tree().get_first_node_in_group("EndlessGameManager").update_points.bind(1)) # TODO Point per kill
	get_parent().add_child(inst_unit)
