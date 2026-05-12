extends UpgradeRes

var health_mod: int

func _init() -> void:
	name = "Max Health Up"
	description = "Increases how much damage you can take before going down!"
	synergy = UpgradeSynergy.BLUE
	icon = null

func get_effect(player: Player):
	player.max_health += health_mod
	player.current_health += health_mod
