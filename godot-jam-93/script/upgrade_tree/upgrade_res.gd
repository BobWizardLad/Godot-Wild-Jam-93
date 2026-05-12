@abstract class_name UpgradeRes
extends Resource
## Resource for upgrade behavior. Holds the synergy type of the upgrade as well as the
## custom behavior of the upgrade

enum UpgradeSynergy {
	RED,
	BLUE,
	GREEN,
	COLORLESS
}

@export var name : StringName
@export var description: String
@export var synergy : UpgradeSynergy

@abstract func get_effect(player: Player)
