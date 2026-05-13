class_name UpgradeTreeController
extends UpgradeTreeNode
## Controller for all upgrade tree nodes: handles accessing the tree's buffs as well
## as converting the tree into a visual, editable resource

func _init(this_upgrades: Array[UpgradeRes] = [], this_sprite: Texture2D = null, this_root_connection: UpgradeTreeConnection = null) -> void:
	super(this_upgrades, this_sprite, this_root_connection)
	
	max_connections = 4

func _ready() -> void:
	neighbor_children_if_connection()

## Return the root of a series of UpgradeTreeNodes that compose this controller's current build
func get_visual_upgrade_tree() -> Node2D:
	return Node2D.new()

## Check to see if a potential
func is_neighbor_valid(incoming_connection: UpgradeTreeConnection, my_connection: UpgradeTreeConnection) -> bool:
	return incoming_connection.joint == my_connection.joint

func add_neighbor_at(this_neighbor: UpgradeTreeNode, connection_idx: int) -> bool:
	if is_neighbor_valid(this_neighbor.root_connection, connections_out[connection_idx]):
		connections_out[connection_idx].neighbor = this_neighbor
		return true
	else:
		return false

func add_new_neighbor(upgrade_node: UpgradeTreeNode) -> bool:
	for child in connections_out:
		if is_neighbor_valid(upgrade_node.root_connection, child):
			child.neighbor = upgrade_node
			add_child(upgrade_node)
			apply_upgrades_in_tree(get_parent())
			return true
	return false

func neighbor_children_if_connection() -> bool:
	for child in get_children():
		if child is UpgradeTreeNode:
			for connection in connections_out:
				if is_neighbor_valid(child.root_connection, connection):
					connection.neighbor = child
					child.root_connection.neighbor = self
		assert(child.root_connection.neighbor != null, "UpgradeTreeRare " + name + " has an incompatible child " + child.name)
	return true
