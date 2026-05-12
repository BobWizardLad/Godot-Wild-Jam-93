@abstract class_name UpgradeTreeNode
extends Node

## Holds all data for any base upgrade tree node, such as upgrades and root connection

@export var upgrades: Array[UpgradeRes]
@export var sprite: Texture2D
@export var root_connection: UpgradeTreeConnection

## Initialize a node from script
func _init(this_upgrades: Array[UpgradeRes] = [], this_sprite: Texture2D = null, this_root_connection: UpgradeTreeConnection = null) -> void:
	upgrades = this_upgrades
	sprite = this_sprite
	root_connection = this_root_connection
