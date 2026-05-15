class_name UpgradeFactory
extends Node

## Object that generates an upgrade piece upon request.
@export_group("Upgrade Archetypes")
@export var common_upgrade_archetypes: Array[PackedScene]
@export var rare_upgrade_archetypes: Array[PackedScene]
@export var very_rare_upgrade_archetypes: Array[PackedScene]

@export_group("Upgrade Pools")
@export var common_upgrade_pool: Array[UpgradeRes]
@export var common_max_upgrades: int
@export var rare_upgrade_pool: Array[UpgradeRes]
@export var rare_max_upgrades: int
@export var very_rare_upgrade_pool: Array[UpgradeRes]
@export var very_rare_max_upgrades: int

@export_group("Spawn Settings")
@export var spawn_min_Y: float
@export var spawn_max_Y: float
@export var spawn_min_X: float
@export var spawn_max_X: float

func get_common() -> UpgradeTreeCommon:
	var upgrade_node: UpgradeTreeCommon = common_upgrade_archetypes[randi_range(0, common_upgrade_archetypes.size()-1)].instantiate()
	for each in range(0, randi_range(1, common_max_upgrades)): # randomly 1-MAX upgrades in node
		var new_upgrade: UpgradeRes = common_upgrade_pool[randi_range(0, common_upgrade_pool.size()-1)].duplicate(true) # draw an upgrade from pool
		new_upgrade.init_effect_value()
		upgrade_node.upgrades.append(new_upgrade)
	upgrade_node.position = Vector2(randf_range(spawn_min_X, spawn_max_X), randf_range(spawn_min_Y, spawn_max_Y))
	return upgrade_node

func get_rare() -> UpgradeTreeRare:
	return

func get_very_rare() -> UpgradeTreeVeryRare:
	return
