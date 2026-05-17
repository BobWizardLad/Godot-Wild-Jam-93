class_name MoveSpeedUpgrade
extends UpgradeRes

var speed_mod: float
@export var speed_mod_range: Vector2

func init_effect_value() -> void:
	speed_mod = randf_range(speed_mod_range.x, speed_mod_range.y)

func get_effect(player: Player):
	player.SPEED *= speed_mod

func create_tooltip_label() -> UpgradeLabel:
	var new_label: UpgradeLabel = label_template.instantiate()
	new_label.set_label_data(name, description, str("%.2f" % speed_mod) + "x")
	return new_label
