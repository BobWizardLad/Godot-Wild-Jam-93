class_name UpgradeTreeRare
extends UpgradeTreeNode

## Special upgrade tree node that has outgoing connections like root AND a synergy
## that enhences upgrades associated with it (in it or adjacent to it)

@export var synergy : UpgradeRes.UpgradeSynergy
@export var connections_out: Array[UpgradeTreeConnection]
@export var max_connections: int
 
