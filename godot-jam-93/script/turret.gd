extends StaticBody2D

var bullet_asset: PackedScene = load("res://components/bullet.tscn")
@onready var cooldown: Timer = $ShootCooldown

@export var bullet_speed: float
@export var fire_rate: float
@export var bullet_lifetime: float

func _ready() -> void:
	cooldown.wait_time = fire_rate

func shoot():
	for each in [Vector2.DOWN, Vector2.LEFT, Vector2.UP, Vector2.RIGHT]:
		get_parent().add_child(spawn_moving_bullet(each))

func spawn_moving_bullet(velocity: Vector2) -> CharacterBody2D:
	var bullet = bullet_asset.instantiate()
	bullet.velocity = velocity * bullet_speed
	bullet.global_position = global_position + Vector2(0.0, -4.0)
	bullet.lifetime = bullet_lifetime
	return bullet
