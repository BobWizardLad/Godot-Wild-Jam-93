class_name UpgradeTreeConnection
extends Resource
## Resource that represents a logical connection between two upgrade nodes.
## holds joint info and a reference to it's outgoing connection neighbor

enum UpgradeNodeJoint {
	A,
	B,
	C,
	D
}

@export var joint: UpgradeNodeJoint
@export var neighbor: UpgradeTreeNode

## Initialize the connection from script
func _init(this_joint: UpgradeNodeJoint, this_neighbor: UpgradeTreeNode = null) -> void:
	joint = this_joint
	neighbor = this_neighbor
