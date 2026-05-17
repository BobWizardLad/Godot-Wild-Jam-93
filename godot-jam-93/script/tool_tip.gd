class_name ToolTip
extends PanelContainer

@onready var upgrade_label_container: VBoxContainer = $VBoxContainer

@export var display_offset: Vector2

var labels: Array[UpgradeLabel] = []

func _ready() -> void:
	populate_labels()

func populate_labels() -> void:
	for each in labels:
		upgrade_label_container.add_child(each)

# Follow the mouse when enabled
func _process(_delta: float) -> void:
	global_position = get_global_mouse_position() + display_offset

func add_new_label(new_label: UpgradeLabel) -> void:
	labels.append(new_label)
