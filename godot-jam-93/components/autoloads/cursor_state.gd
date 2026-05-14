extends Node

var current_draggable_node : DraggableUpgradeTreeNode
var current_hovered_connection : UpgradeTreeConnection
signal draggable_node_picked(node: DraggableUpgradeTreeNode)
signal draggable_node_dropped(node: DraggableUpgradeTreeNode)

## Setter for current_draggable_node. Emits changed signal when
## current_draggable_node is changed using this function (DO THIS!!!)
func set_current_draggable_node(new_value: DraggableUpgradeTreeNode):
	if new_value == null:
		draggable_node_dropped.emit(current_draggable_node)
		current_draggable_node = new_value
	else:
		current_draggable_node = new_value
		draggable_node_picked.emit(current_draggable_node)
	print("hoopla")

#func set_current_hovered_connection(new_joint: UpgradeTreeConnection) -> void:
	#current_hovered_connection = new_joint

func set_as_hovered(connection: UpgradeTreeConnection) -> void:
	if current_draggable_node != null and !(connection.is_root) and !(connection in current_draggable_node.connections_out):
		print(connection)
		current_hovered_connection = connection

func remove_as_hovered(_connection: UpgradeTreeConnection) -> void:
	current_hovered_connection = null

func connect_draggable_node_to_hovered_connection() -> bool:
	if current_hovered_connection != null && current_draggable_node != null:
		if current_hovered_connection.is_neighbor_valid(current_draggable_node.root_connection):
			current_hovered_connection.add_connected_node(current_draggable_node)
			return true
	return false
