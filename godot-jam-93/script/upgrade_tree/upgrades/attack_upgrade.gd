class_name AttackUpgrade
extends UpgradeRes

var damage_increase: int
@export var damage_increase_range: Vector2i

func init_effect_value() -> void:
	damage_increase = randi_range(damage_increase_range.x, damage_increase_range.y)

func get_effect(player: Player):
	player.bullet_damage += damage_increase
