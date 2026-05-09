class_name AnimationBlender
extends Node

## The animation tree being handled by this node.
@export var animation_tree: AnimationTree

var playback: AnimationNodeStateMachinePlayback

func _ready():
	playback = animation_tree["parameters/playback"]
