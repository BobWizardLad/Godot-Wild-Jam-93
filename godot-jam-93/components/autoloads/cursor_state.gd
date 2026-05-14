extends Node

var current_draggable_node : DraggableUpgradeTreeNode
var current_hovered_joint : UpgradeTreeConnection
signal draggable_node_changed

## Setter for current_draggable_node. Emits changed signal when
## current_draggable_node is changed using this function (DO THIS!!!)
func set_current_draggable_node(new_value: DraggableUpgradeTreeNode):
	current_draggable_node = new_value
	draggable_node_changed.emit()
	print("hoopla")

#func set_current_hovered_joint(new_joint: UpgradeTreeConnection) -> void:
	#current_hovered_joint = new_joint

func set_as_hovered(connection: UpgradeTreeConnection) -> void:
	if current_draggable_node != null and !(connection.is_root) and !(connection in current_draggable_node.connections_out):
		print(connection)
		current_hovered_joint = connection

func remove_as_hovered(_connection: UpgradeTreeConnection) -> void:
	current_hovered_joint = null
