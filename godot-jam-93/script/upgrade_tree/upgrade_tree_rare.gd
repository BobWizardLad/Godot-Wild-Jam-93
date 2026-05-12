class_name UpgradeTreeRare
extends UpgradeTreeNode

## Special upgrade tree node that has outgoing connections like root AND a synergy
## that enhences upgrades associated with it (in it or adjacent to it)

@export var synergy : UpgradeRes.UpgradeSynergy
@export var connections_out: Array[UpgradeTreeConnection]
@export var max_connections: int
 
## Initialize a node from script
func _init(
	this_connections_out: Array[UpgradeTreeConnection] = [],
	this_root_node: UpgradeTreeConnection = null,
	this_synergy: UpgradeRes.UpgradeSynergy = UpgradeRes.UpgradeSynergy.COLORLESS,
	this_upgrades: Array[UpgradeRes] = [],
	this_sprite: Texture2D = null,
	this_max_connections: int = 3
	) -> void:
	super(this_upgrades, this_sprite, this_root_node)
	synergy = this_synergy
	connections_out = this_connections_out
	max_connections = this_max_connections

func _to_string() -> String:
	var connections_out_string: String = ""
	for each in connections_out:
		connections_out_string = connections_out_string + " " + str(each.neighbor)
	return String(super() + " | Synergy: " + str(synergy) + " | Connections out: " + str(connections_out_string))
