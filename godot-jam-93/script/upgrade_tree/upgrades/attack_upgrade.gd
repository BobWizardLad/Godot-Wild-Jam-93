extends UpgradeRes

var damage_increase: int

func _init() -> void:
	name = "Bullet Damage"
	description = "Increases the damage your gun will do!"
	synergy = UpgradeSynergy.RED
	icon = null

func get_effect(player: Player):
	player.bullet_damage += damage_increase
