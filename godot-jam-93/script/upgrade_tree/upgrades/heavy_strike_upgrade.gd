class_name HeavyStrikeUpgrade
extends UpgradeRes

func init_effect_value() -> void:
	pass
	
func get_effect(player: Player):
	player.bullet_is_heavy_strike = true

func create_tooltip_label() -> UpgradeLabel:
	var new_label: UpgradeLabel = label_template.instantiate()
	new_label.set_label_data(name, description, "+")
	return new_label
