@abstract class_name UpgradeTreeNode
extends Node2D

## Holds all data for any base upgrade tree node, such as upgrades and root connection

@export var upgrades: Array[UpgradeRes]
@export var sprite: Texture2D
@export var root_connection: UpgradeTreeConnection
@export var connections_out: Array[UpgradeTreeConnection]
var max_connections

## Initialize a node from script
func _init(this_upgrades: Array[UpgradeRes] = [], this_sprite: Texture2D = null, this_root_connection: UpgradeTreeConnection = null) -> void:
	upgrades = this_upgrades
	sprite = this_sprite
	root_connection = this_root_connection
	
	max_connections = 0

## Given a player as a paremeter, go sequentially through the upgrade tree and 
## apply all upgrades in this tree.
func apply_upgrades_in_tree(player: Player) -> void:
	# apply my upgrades first
	for each in upgrades:
		print("Applying " + str(each.name))
		each.get_effect(player)
	# ... then seek all children
	for each in connections_out:
		if each.neighbor != null:
			each.neighbor.apply_upgrades_in_tree(player)
	
