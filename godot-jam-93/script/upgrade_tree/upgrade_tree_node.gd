@abstract class_name UpgradeTreeNode
extends Resource

## Holds all data for any base upgrade tree node, such as upgrades and root connection

@export var upgrades: Array[UpgradeRes]
@export var sprite: Texture2D
@export var root_node: UpgradeTreeConnection

## Initialize a node from script
func _init(this_upgrades: Array[UpgradeRes] = [], this_sprite: Texture2D = null, this_root_node: UpgradeTreeConnection = null) -> void:
	upgrades = this_upgrades
	sprite = this_sprite
	root_node = this_root_node

func _to_string() -> String:
	return String("UpgradeTreeNode" + " | with upgrades " + str(upgrades) + " | root_node neighbor " + str(root_node.neighbor))
