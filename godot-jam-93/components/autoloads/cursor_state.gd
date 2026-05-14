extends Node

var current_draggable_node : DraggableUpgradeTreeNode
signal draggable_node_changed

## Setter for current_draggable_node. Emits changed signal when
## current_draggable_node is changed using this function (DO THIS!!!)
func set_current_draggable_node(new_value: DraggableUpgradeTreeNode):
	current_draggable_node = new_value
	draggable_node_changed.emit()
	print("hoopla")
