class_name DashCooldownUpgrade
extends UpgradeRes

var dash_cooldown_mod: float
@export var dash_cooldown_mod_range: Vector2

func init_effect_value() -> void:
	dash_cooldown_mod = randf_range(dash_cooldown_mod_range.x, dash_cooldown_mod_range.y)

func get_effect(player: Player):
	player.dash_cooldown_time *= dash_cooldown_mod

func create_tooltip_label() -> UpgradeLabel:
	var new_label: UpgradeLabel = label_template.instantiate()
	new_label.set_label_data(name, description, str("%.2f" % dash_cooldown_mod) + "x")
	return new_label
