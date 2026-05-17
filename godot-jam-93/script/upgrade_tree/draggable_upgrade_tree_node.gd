class_name DraggableUpgradeTreeNode
extends UpgradeTreeNode
## Is a draggable version of the UpgradeTreeNode by the mouse

@onready var tooltip_template: PackedScene = load("res://godot-jam-93/components/UI/tool_tip.tscn")

var is_grabbed: bool
## Is the mouse hovering this for the purpose of inputs?
var mouse_is_hover: bool
## The active tooltip instance; delete when mouse leaves or when picked up
var tooltip_instance: ToolTip

## Initialize a node
func _init(
	this_upgrades: Array[UpgradeRes] = [],
	this_sprite: Texture2D = null,
	this_root_node: UpgradeTreeConnection = null
	) -> void:
	super(this_upgrades, this_sprite, this_root_node)
	
	is_grabbed = false
	mouse_is_hover = false

func _ready():
	$DragArea.mouse_entered.connect(_on_drag_area_mouse_entered)
	$DragArea.mouse_exited.connect(_on_drag_area_mouse_exited)

func _unhandled_input(event: InputEvent) -> void:
	if CursorState.current_draggable_node == null and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and mouse_is_hover:
		if sizeof_connections_out() == 0:
			CursorState.set_current_draggable_node(self)
			is_grabbed = true
	if event is InputEventMouseButton and !event.pressed and CursorState.current_draggable_node == self:
		CursorState.set_current_draggable_node(null)
		is_grabbed = false

func _process(delta: float) -> void:
	if is_grabbed:
		display_valid_connections(null)
		dragging(delta)

func snap_to_connection(snap_connection: UpgradeTreeConnection) -> void:
	global_position = snap_connection.node_parent.global_position + get_snap_offset(get_connection_orientation(snap_connection), snap_connection.position.length() + root_connection.position.length())
	print(snap_connection.position.normalized())
	global_rotation = align_root_to_joint(snap_connection.position.normalized()) + snap_connection.node_parent.global_rotation
	print(global_rotation_degrees)

func dragging(_delta: float):
	var mouse_target = get_global_mouse_position()
	global_position = lerp(global_position, mouse_target, 0.33)

func get_snap_offset(orientation: Vector2, distance: float) -> Vector2:
	return orientation * distance

func get_connection_orientation(connection: UpgradeTreeConnection) -> Vector2:
	if connection.global_position.x < connection.node_parent.global_position.x:
		return Vector2.LEFT
	elif connection.global_position.x > connection.node_parent.global_position.x:
		return Vector2.RIGHT
	elif connection.global_position.y > connection.node_parent.global_position.y:
		return Vector2.DOWN
	elif connection.global_position.y < connection.node_parent.global_position.y:
		return Vector2.UP
	else:
		return Vector2.ZERO

func align_root_to_joint(vector: Vector2) -> float:
	match vector:
		Vector2.DOWN:
			return PI/2
		Vector2.LEFT:
			return PI
		Vector2.UP:
			return (3*PI)/2
		Vector2.RIGHT:
			return 0
	push_warning("DraggableUpgradeTreeNode: Invalid normal vector given. Beware uncommon rotation!")
	return -1

func show_tooltip() -> void:
	if upgrades.size() > 0:
		tooltip_instance = tooltip_template.instantiate()
		for each in upgrades:
			tooltip_instance.add_new_label(each.create_tooltip_label())
		get_parent().add_child(tooltip_instance)
	else:
		return

func remove_tooltip() -> void:
	tooltip_instance.queue_free()
	tooltip_instance = null

func _on_drag_area_mouse_entered() -> void:
	show_tooltip()
	mouse_is_hover = true

func _on_drag_area_mouse_exited() -> void:
	remove_tooltip()
	mouse_is_hover = false
