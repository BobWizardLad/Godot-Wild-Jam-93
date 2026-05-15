class_name UpgradeTreeConnection
extends Area2D
## Detectable Point that represents a logical connection between two upgrade nodes.
## holds joint info and a reference to its outgoing connection neighbor

enum UpgradeNodeJoint {
	A,
	B,
	C,
	D,
	X
}

@onready var polygon_indicator : Polygon2D = $Indicator

@export var joint: UpgradeNodeJoint
@export var is_root: bool = false
var neighbor: UpgradeTreeNode

func _ready() -> void:
	mouse_entered.connect(CursorState.set_as_hovered.bind(self))
	mouse_exited.connect(CursorState.remove_as_hovered.bind(self))
	CursorState.draggable_node_picked.connect(remove_picked_node)

## Return if an incoming connection is valid against this connection
func is_neighbor_valid(incoming_connection: UpgradeTreeConnection) -> bool:
	return (incoming_connection.joint == joint || incoming_connection.joint == UpgradeNodeJoint.X) && neighbor == null

## Shows or hides the indicator for this joint based on is_displaying
func display_indicator(is_displaying: bool) -> void:
	polygon_indicator.visible = is_displaying

func remove_connected_node() -> void:
	neighbor = null

func remove_picked_node(picked_node: DraggableUpgradeTreeNode) -> void:
	if neighbor == picked_node:
		remove_connected_node()

func add_connected_node(new_node: UpgradeTreeNode) -> void:
	if is_neighbor_valid(new_node.root_connection):
		neighbor = new_node
