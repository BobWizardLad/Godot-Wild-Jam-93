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
