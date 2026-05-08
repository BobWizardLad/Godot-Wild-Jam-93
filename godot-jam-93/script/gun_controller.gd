class_name GunController
extends Node2D

# Makes bullets, hucks them out

## Scene that will be used as a projectile for this gun controller
var bullet_resource: PackedScene = load("res://godot-jam-93/components/bullet.tscn")

## Configuration of bullets that are fired out of this controller
@export_group("Bullet Config")
@export var bullet_speed: float
@export var fire_rate: float
@export var bullet_lifetime: float

## Takes a vector and fires a bullet in the vector's NORMALIZED DIRECTION
# TEST
func shoot(velocity_vector: Vector2) -> void: # TEST
	get_parent().get_parent().add_child(spawn_moving_bullet(velocity_vector))
	
## Takes a vector and returns a bullet object with the given DIRECTION and class-defined SPEED and LIFETIME
## Speed and lifetime are optional parameters defined by the GunController by default
# TEST
func spawn_moving_bullet(vector: Vector2, speed: float = bullet_speed, lifetime: float = bullet_lifetime) -> Node2D:
	var bullet = bullet_resource.instantiate()
	bullet.muzzle_velocity = vector.normalized() * speed
	bullet.global_position = global_position
	bullet.lifetime = lifetime
	return bullet
