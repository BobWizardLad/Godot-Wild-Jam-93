class_name UpgradeTreeController
extends Node
## Controller for all upgrade tree nodes: handles accessing the tree's buffs as well
## as converting the tree into a visual, editable resource

## Given a player as a paremeter, go sequentially through the upgrade tree and 
## apply all upgrades in this tree.
func apply_upgrades_in_tree(player: Player) -> void:
	pass

## Return the root of a series of UpgradeTreeNodes that compose this controller's current build
func get_visual_upgrade_tree() -> Node2D:
	return Node2D.new()
