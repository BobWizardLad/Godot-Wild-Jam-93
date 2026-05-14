class_name UpgradeTreeConnection
extends Area2D
## Detectable Point that represents a logical connection between two upgrade nodes.
## holds joint info and a reference to its outgoing connection neighbor

enum UpgradeNodeJoint {
	A,
	B,
	C,
	D
}

@onready var polygon_indicator : Polygon2D = $Indicator

@export var joint: UpgradeNodeJoint
var neighbor: UpgradeTreeNode

## Return if an incoming connection is valid against this connection
func is_neighbor_valid(incoming_connection: UpgradeTreeConnection) -> bool:
	return incoming_connection.joint == joint

## Shows or hides the indicator for this joint based on is_displaying
func display_indicator(is_displaying: bool) -> void:
	polygon_indicator.visible = is_displaying

func add_connected_node(new_node: UpgradeTreeNode) -> void:
	if is_neighbor_valid(new_node.root_connection):
		neighbor = new_node
