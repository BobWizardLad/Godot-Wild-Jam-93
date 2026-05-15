class_name UpgradeTreeCommon
extends DraggableUpgradeTreeNode

## Upgrade Node with only one root node that accesses specific upgrades

## Initialize a node from script
func _init(
	this_upgrades: Array[UpgradeRes] = [],
	this_sprite: Texture2D = null,
	this_root_node: UpgradeTreeConnection = null
	) -> void:
	super(this_upgrades, this_sprite, this_root_node)
