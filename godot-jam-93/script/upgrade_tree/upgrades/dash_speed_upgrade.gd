class_name DashSpeedUpgrade
extends UpgradeRes

var dash_speed_increase: float
@export var dash_speed_increase_range: Vector2

func init_effect_value() -> void:
	dash_speed_increase = randf_range(dash_speed_increase_range.x, dash_speed_increase_range.y)

func get_effect(player: Player):
	player.dash_speed *= dash_speed_increase

func create_tooltip_label() -> UpgradeLabel:
	var new_label: UpgradeLabel = label_template.instantiate()
	new_label.set_label_data(name, description, str("%.2f" % dash_speed_increase) + "x")
	return new_label
