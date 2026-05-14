class_name DraggableUpgradeTreeNode
extends UpgradeTreeNode

## Is a draggable version of the UpgradeTreeNode by the mouse

var is_grabbed: bool
## Is the mouse hovering this for the purpose of inputs?
var mouse_is_hover: bool

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
		CursorState.set_current_draggable_node(self)
		is_grabbed = true
	if event is InputEventMouseButton and !event.pressed and CursorState.current_draggable_node == self:
		CursorState.set_current_draggable_node(null)
		is_grabbed = false

func _process(delta: float) -> void:
	if is_grabbed:
		dragging(delta)

func dragging(delta: float):
	var mouse_target = get_global_mouse_position()
	global_position = lerp(global_position, mouse_target, 0.33)

func _on_drag_area_mouse_entered() -> void:
	mouse_is_hover = true

func _on_drag_area_mouse_exited() -> void:
	mouse_is_hover = false
