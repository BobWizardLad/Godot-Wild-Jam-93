class_name GunController
extends Node2D

# Makes bullets, hucks them out

## Scene that will be used as a projectile for this gun controller
@export var bullet_resource: PackedScene

## Configuration of bullets that are fired out of this controller
@export_group("Bullet Config")
@export var bullet_speed: float
@export var fire_cooldown: float
@export var bullet_lifetime: float

@export_group("Sound FX")
@export var sfx_shoot: AudioStream

@onready var cooldown: Timer = $Cooldown
@onready var sound_sequencer: SoundSequencer2D = $SoundSequencer2D

## Takes a vector and fires a bullet in the vector's NORMALIZED DIRECTION
func shoot(velocity_vector: Vector2) -> void:
	if cooldown.is_stopped():
		sound_sequencer._queue_audio_track(sfx_shoot)
		get_parent().get_parent().add_child(spawn_moving_bullet(velocity_vector))
		cooldown.start(fire_cooldown)
	
## Takes a vector and returns a bullet object with the given DIRECTION and class-defined SPEED and LIFETIME
## Speed and lifetime are optional parameters defined by the GunController by default
func spawn_moving_bullet(vector: Vector2, speed: float = bullet_speed, lifetime: float = bullet_lifetime) -> Node2D:
	var bullet = bullet_resource.instantiate()
	bullet.muzzle_velocity = vector.normalized() * speed
	bullet.global_position = global_position
	bullet.lifetime = lifetime
	return bullet
