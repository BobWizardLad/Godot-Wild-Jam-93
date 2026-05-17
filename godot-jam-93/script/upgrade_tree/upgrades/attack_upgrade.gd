class_name AttackUpgrade
extends UpgradeRes

var damage_increase: int
@export var damage_increase_range: Vector2i

func init_effect_value() -> void:
	damage_increase = randi_range(damage_increase_range.x, damage_increase_range.y)

func get_effect(player: Player):
	player.damage += damage_increase

func create_tooltip_label() -> UpgradeLabel:
	var new_label: UpgradeLabel = label_template.instantiate()
	new_label.set_label_data(name, description, "+" + str(damage_increase))
	return new_label
