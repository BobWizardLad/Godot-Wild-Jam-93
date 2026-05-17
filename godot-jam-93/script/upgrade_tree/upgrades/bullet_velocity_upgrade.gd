class_name BulletVelocityUpgrade
extends UpgradeRes

var bullet_speed_mod: float
@export var bullet_speed_range: Vector2i

func init_effect_value() -> void:
	bullet_speed_mod = randi_range(bullet_speed_range.x, bullet_speed_range.y)

func get_effect(player: Player):
	player.bullet_speed += bullet_speed_mod

func create_tooltip_label() -> UpgradeLabel:
	var new_label: UpgradeLabel = label_template.instantiate()
	new_label.set_label_data(name, description, "+" + str(bullet_speed_mod))
	return new_label
