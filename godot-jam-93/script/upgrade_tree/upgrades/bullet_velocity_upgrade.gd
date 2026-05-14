class_name BulletVelocityUpgrade
extends UpgradeRes

var bullet_speed_mod: float
@export var bullet_speed_range: Vector2

func init_effect_value() -> void:
	bullet_speed_mod = randf_range(bullet_speed_range.x, bullet_speed_range.y)

func get_effect(player: Player):
	player.bullet_speed += bullet_speed_mod
