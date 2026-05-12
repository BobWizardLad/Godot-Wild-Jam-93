extends UpgradeRes

var bullet_speed_mod: float

func _init() -> void:
	name = "Bullet Velocity"
	description = "Increases the speed your bullets fly! Faster shooting means deader enemies quicker!"
	synergy = UpgradeSynergy.RED
	icon = null

func get_effect(player: Player):
	player.bullet_speed += bullet_speed_mod
