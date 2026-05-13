class_name MoveSpeedUpgrade
extends UpgradeRes

var speed_mod: float
@export var speed_mod_range: Vector2

func init_effect_value() -> void:
	speed_mod = randf_range(speed_mod_range.x, speed_mod_range.y)

func get_effect(player: Player):
	player.SPEED *= speed_mod
