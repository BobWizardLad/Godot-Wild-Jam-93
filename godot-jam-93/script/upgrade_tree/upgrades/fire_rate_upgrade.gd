class_name FirerateUpgrade
extends UpgradeRes

var cooldown_mod: float
@export var cooldown_mod_range: Vector2

func init_effect_value() -> void:
	cooldown_mod = randf_range(cooldown_mod_range.x, cooldown_mod_range.y)

func get_effect(player: Player):
	player.fire_cooldown *= cooldown_mod

func create_tooltip_label() -> UpgradeLabel:
	var new_label: UpgradeLabel = label_template.instantiate()
	new_label.set_label_data(name, description, str("%.2f" % cooldown_mod) + "x")
	return new_label
