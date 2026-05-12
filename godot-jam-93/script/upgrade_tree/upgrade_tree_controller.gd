class_name UpgradeTreeController
extends UpgradeTreeNode
## Controller for all upgrade tree nodes: handles accessing the tree's buffs as well
## as converting the tree into a visual, editable resource

@export var connections_out: Array[UpgradeTreeConnection]
const MAX_CONNECTIONS = 4

func _ready() -> void:
	pass

## Given a player as a paremeter, go sequentially through the upgrade tree and 
## apply all upgrades in this tree.
func apply_upgrades_in_tree(player: Player) -> void:
	pass

## Return the root of a series of UpgradeTreeNodes that compose this controller's current build
func get_visual_upgrade_tree() -> Node2D:
	return Node2D.new()

## Check to see if a potential
func is_neighbor_valid(this_neighbor: UpgradeTreeNode, connection_idx: int) -> bool:
	return this_neighbor.root_node.joint == connections_out[connection_idx].joint

func add_neighbor(this_neighbor: UpgradeTreeNode, connection_idx: int) -> bool:
	if is_neighbor_valid(this_neighbor, connection_idx):
		connections_out[connection_idx].neighbor = this_neighbor
		return true
	else:
		return false

func neighbor_children_if_connection() -> bool:
	for child in get_children():
		if child is UpgradeTreeNode:
			for connection in connections_out:
				if child.root_connection.joint == connection.joint:
					connection.neighbor = child
					child.root_connection.neighbor = self
		assert(child.root_connection.neighbor != null, "UpgradeTreeRare " + name + " has an incompatible child " + child.name)
	return true
