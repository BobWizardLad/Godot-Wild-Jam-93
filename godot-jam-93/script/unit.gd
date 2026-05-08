class_name Unit
extends CharacterBody2D

signal damage_taken(value: int)
signal damage_stopped(value: int)
signal died

@export var SPEED: float
@export var BASIC_DAMAGE: int
@export var BASIC_COOLDOWN_TIME: float

var direction: Vector2

var is_forced_moving: bool = false


var basic_cooldown: Timer
var health_overlay: TextureProgressBar

@export var is_invincible: bool = false
## Flag for if the player is currently attacking.
@export var is_attacking: bool = false
@export var max_health: int
@export var current_health: int

func _ready() -> void:
	assert($"UI Overlay/HealthDisplay" != null, "Unit " + str(self) + " does not have HealthDisplay in UI Overlay object")
	health_overlay = $"UI Overlay/HealthDisplay"
	print(health_overlay)
	health_overlay.value = current_health
	direction = Vector2.ZERO

func take_damage(value: int, source: Node2D = self, heavy_strike: bool = false):
	if not is_invincible:
		current_health -= value
		damage_taken.emit(value)
		health_overlay.value = current_health
		if current_health > max_health:
			current_health = max_health
		if current_health <= 0:
			current_health = 0
			died.emit()
		
		if heavy_strike:
			forced_move(-1 * global_position.direction_to(source.global_position), 35.0, 0.3)
	else:
		damage_stopped.emit(value)

## Function that defines the basic attack of a Unit
func basic_attack(_damage_mod: int = 1, cooldown: float = BASIC_COOLDOWN_TIME, _is_heavy_strike: bool = false):
	is_attacking = true
	basic_cooldown.start(cooldown)

## Returns a unit vector in one of 8 directions derived from a given x and y float
func capture_direction(x: float, y: float) -> Vector2:
	if x < 0:
		if y > 0:
			return Vector2(-0.707, 0.707)
		if y == 0:
			return Vector2.LEFT
		if y < 0:
			return Vector2(-0.707, -0.707)
	elif x == 0:
		if y < 0:
			return Vector2.UP
		if y > 0:
			return Vector2.DOWN
	elif x > 0:
		if y > 0:
			return Vector2(0.707, 0.707)
		if y == 0:
			return Vector2.RIGHT
		if y < 0:
			return Vector2(0.707, -0.707)
	return Vector2.ZERO

func forced_move(forced_direction: Vector2, distance: float, time: float):
	is_forced_moving = true
	var tween = get_tree().create_tween()
	tween.tween_property(
		self,
		"position",
		position + (forced_direction.normalized() * distance),
		time
	).set_trans(Tween.TRANS_SINE)
	await tween.finished
	is_forced_moving = false

func basic_cooldown_timeout():
	is_attacking = false
