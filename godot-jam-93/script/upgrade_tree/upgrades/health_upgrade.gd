class_name HealthUpgrade
extends UpgradeRes

var health_mod: int
@export var health_mod_range: Vector2i

func init_effect_value() -> void:
	health_mod = randi_range(health_mod_range.x, health_mod_range.y)

func get_effect(player: Player):
	player.max_health += health_mod

func create_tooltip_label() -> UpgradeLabel:
	var new_label: UpgradeLabel = label_template.instantiate()
	new_label.set_label_data(name, description, "+" + str(health_mod))
	return new_label
