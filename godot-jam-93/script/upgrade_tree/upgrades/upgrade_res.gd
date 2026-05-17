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

var label_template: PackedScene = load("res://godot-jam-93/components/UI/upgrade_label.tscn")

@export var name: StringName
@export var description: String
@export var synergy: UpgradeSynergy
@export var icon: Texture2D
@export var synergy_amplification: float

@abstract func get_effect(player: Player) -> void
@abstract func init_effect_value() -> void
@abstract func create_tooltip_label() -> UpgradeLabel
