class_name Unit
extends CharacterBody2D

signal damage_taken(value: int)
signal damage_stopped()
signal health_recalculated(new_value: float)
signal died

@export var SPEED: float

var direction: Vector2

var is_forced_moving: bool = false
var is_dead: bool = false
var is_invincible: bool = false
## Flag for if the player is currently attacking.
@export var max_health: int
@export var current_health: int

func _ready() -> void:
	direction = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if !is_forced_moving:
		velocity = derive_unit_velocity()
	move_and_slide()

func take_damage(value: int, source: Node2D = self, heavy_strike: bool = false):
	if is_invincible:
		damage_stopped.emit()
	else:
		current_health -= value
		damage_taken.emit(value)
		if current_health > max_health:
			current_health = max_health
		if current_health <= 0:
			current_health = 0
			is_dead = true
			died.emit()
		if heavy_strike:
			forced_move(-1 * global_position.direction_to(source.global_position), 115.0, 0.3)
		health_recalculated.emit(current_health)

func derive_unit_velocity() -> Vector2:
	return Vector2.ZERO

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

func forced_move(forced_direction: Vector2, speed: float, time: float):
	is_forced_moving = true
	direction = forced_direction
	velocity = forced_direction * speed
	get_tree().create_timer(time).timeout.connect(stop_forced_moving)

## By default (and usually at least) a unit is freed when they die
func die() -> void:
	queue_free()

func stop_forced_moving():
	is_forced_moving = false
