class_name UpgradeTreeRare
extends UpgradeTreeNode

## Special upgrade tree node that has outgoing connections like root AND a synergy
## that enhences upgrades associated with it (in it or adjacent to it)

@export var synergy : UpgradeRes.UpgradeSynergy
 
## Initialize a node from script
func _init(
	this_connections_out: Array[UpgradeTreeConnection] = [],
	this_root_node: UpgradeTreeConnection = null,
	this_synergy: UpgradeRes.UpgradeSynergy = UpgradeRes.UpgradeSynergy.COLORLESS,
	this_upgrades: Array[UpgradeRes] = [],
	this_sprite: Texture2D = null,
	) -> void:
	super(this_upgrades, this_sprite, this_root_node)
	synergy = this_synergy
	connections_out = this_connections_out
	
	max_connections = 3

func neighbor_children_if_connection() -> bool:
	for child in get_children():
		if child is UpgradeTreeNode:
			for connection in connections_out:
				if child.root_connection.joint == connection.joint:
					connection.neighbor = child
		assert(child.root_connection.neighbor != null, "UpgradeTreeRare " + name + " has an incompatible child " + child.name)
	return true
