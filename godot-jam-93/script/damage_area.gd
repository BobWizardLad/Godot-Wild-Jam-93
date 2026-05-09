class_name DamageArea
extends Area2D

signal attacked_body(body: Node2D)

@export var damage: int
@export var is_heavy_strike: bool

## The damage area cannot cause damage if it is 'dead'
var is_dead: bool = false

func on_body_entered(body: Node2D):
	if body is Unit && !is_dead:
		attacked_body.emit(body)
		body.take_damage(damage, self, is_heavy_strike)
		is_dead = true
	else:
		return
