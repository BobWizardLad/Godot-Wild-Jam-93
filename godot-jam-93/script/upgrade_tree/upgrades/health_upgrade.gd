class_name HealthUpgrade
extends UpgradeRes

var health_mod: int
@export var health_mod_range: Vector2i

func init_effect_value() -> void:
	health_mod = randi_range(health_mod_range.x, health_mod_range.y)

func get_effect(player: Player):
	player.max_health += health_mod
	player.current_health += health_mod
