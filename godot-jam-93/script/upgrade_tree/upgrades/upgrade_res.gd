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

var name: StringName
var description: String
var synergy: UpgradeSynergy
var icon: Texture2D

@abstract func get_effect(player: Player)
