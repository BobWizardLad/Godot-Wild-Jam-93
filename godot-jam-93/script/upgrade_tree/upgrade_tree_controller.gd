class_name UpgradeTreeController
extends UpgradeTreeNode
## Controller for all upgrade tree nodes: handles accessing the tree's buffs as well
## as converting the tree into a visual, editable resource

signal upgrade_tree_modified

func _init(this_upgrades: Array[UpgradeRes] = [], this_sprite: Texture2D = null, this_root_connection: UpgradeTreeConnection = null) -> void:
	super(this_upgrades, this_sprite, this_root_connection)

func _ready() -> void:
	global_position = get_viewport_rect().get_center()
	
	## Connect cursor state to the controller
	CursorState.draggable_node_picked.connect(_on_draggable_picked)
	CursorState.draggable_node_dropped.connect(_on_draggable_dropped)

func _on_draggable_picked(_draggable_node: DraggableUpgradeTreeNode) -> void:
	display_valid_connections(CursorState.current_draggable_node.root_connection)

func _on_draggable_dropped(_draggable_node: DraggableUpgradeTreeNode) -> void:
	if str(CursorState.connect_draggable_node_to_hovered_connection()):
		upgrade_tree_modified.emit()
	display_valid_connections(null)

# WARNING This is just an iffy piece of state stuff if anything connecting nodes goes wrong
# TODO move most of this logic to the cursor singleton probs
#func _on_cursor_state_changed() -> void:
	#if current_draggable_node != null:
		#display_valid_connections(current_draggable_node.root_connection)
	#else:
		#if current_hovered_connection.is_neighbor_valid(current_draggable_node.root_connection):
			#current_hovered_connection.add_connected_node(current_draggable_node)
			#current_draggable_node.root_connection.add_connected_node(current_hovered_connection.get_parent())
		#display_valid_connections(null)

#func add_neighbor_at(this_neighbor: UpgradeTreeNode, connection_idx: int) -> bool:
	#if is_neighbor_valid(this_neighbor.root_connection, connections_out[connection_idx]):
		#connections_out[connection_idx].neighbor = this_neighbor
		#return true
	#else:
		#return false
#
#func add_new_neighbor(upgrade_node: UpgradeTreeNode) -> bool:
	#for child in connections_out:
		#if is_neighbor_valid(upgrade_node.root_connection, child):
			#child.neighbor = upgrade_node
			#add_child(upgrade_node)
			#apply_upgrades_in_tree(get_parent())
			#return true
	#return false

#func neighbor_children_if_connection() -> bool:
	#for child in get_children():
		#if child is UpgradeTreeNode:
			#for connection in connections_out:
				#if is_neighbor_valid(child.root_connection, connection):
					#connection.neighbor = child
					#child.root_connection.neighbor = self
		#assert(child.root_connection.neighbor != null, "UpgradeTreeRare " + name + " has an incompatible child " + child.name)
	#return true
