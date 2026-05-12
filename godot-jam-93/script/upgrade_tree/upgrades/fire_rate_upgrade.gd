extends UpgradeRes

var cooldown_mod: float

func _init() -> void:
	name = "Fire rate increase"
	description = "Increases the fire rate of your gun! More bullets!"
	synergy = UpgradeSynergy.RED
	icon = null

func get_effect(player: Player):
	player.fire_cooldown += cooldown_mod
