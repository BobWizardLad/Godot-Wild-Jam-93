class_name Player
extends Unit

@export var dash_distance: float
@export var dash_time: float
@export var dash_cooldown_time: float
@onready var dash_cooldown: Timer = $DashCooldown

@onready var animation_blender: AnimationBlender = $MovementBlender

## How long a queued attack input will persist before being discarded
@export var attack_queue_decay: float
## Multiplier for movespeed when attacking
@export var attack_slowdown: float
@onready var basic_attack_area: DamageArea = $BasicAttackArea
## Flag for if an attack has been queued
var attack_queued: bool = false
var basic_attack_offset: float = 20.0

func _ready() -> void:
	super()
	basic_cooldown = $BasicCooldown
	basic_cooldown.timeout.connect(basic_cooldown_timeout)
	

func _physics_process(delta: float) -> void:
	velocity = _derive_unit_velocity()
	animation_blender.update_animation_parameters(self)
	if is_forced_moving:
		pass
	if is_attacking:
		velocity *= attack_slowdown
		move_and_slide()
	else:
		move_and_slide()
	velocity = Vector2.ZERO

func _process(delta: float) -> void:
	# rescue condition to stop trying to attack if attack cooldown is finished
	if basic_cooldown.is_stopped():
		is_attacking = false
	if current_health == 0:
		pass # Do player death stuff
	if attack_queued && !is_forced_moving:
		basic_attack()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_key"):
		forced_move(Vector2.DOWN, 25, 0.3)
	if event.is_action_pressed("dash") && dash_cooldown.is_stopped() && direction != Vector2.ZERO:
		dash_movement(direction)
	if event.is_action_pressed("basic_attack") && !attack_queued && !is_attacking:
		attempt_basic_attack(attack_queue_decay)

## Function that returns the calculated velocity of a unit.
func _derive_unit_velocity() -> Vector2:
	# Get axis input
	var input_dir: Vector2 
	input_dir.x = Input.get_axis("player_left", "player_right")
	input_dir.y = Input.get_axis("player_up", "player_down")
	
	if input_dir != Vector2.ZERO:
		direction = capture_direction(input_dir.x, input_dir.y)
	
	return input_dir.normalized() * SPEED

func dash_movement(dash_direction: Vector2 = direction, distance: float = dash_distance, time: float = dash_time, cooldown: float = dash_cooldown_time):
	dash_cooldown.start(cooldown)
	is_forced_moving = true
	var tween = get_tree().create_tween()
	animation_blender.animate_dodge()
	tween.tween_property(
		self,
		"position",
		position + (dash_direction.normalized() * distance),
		time
	).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	is_forced_moving = false

## Function called first for an attack: respects non-attack windows and queues an attack if
## the state does not allow an attack
func attempt_basic_attack(queued_lifetime: float):
	if is_forced_moving:
		attack_queued = true
		get_tree().create_timer(queued_lifetime).timeout.connect(attack_queue_expired)
	else:
		basic_attack()

func basic_attack(damage_mod: int = 1, cooldown: float = BASIC_COOLDOWN_TIME, is_heavy_strike: bool = false):
	super(damage_mod, cooldown, is_heavy_strike)
	basic_attack_area.position = direction * basic_attack_offset
	animation_blender.animate_basic_attack()
	attack_queued = false

## Quick callable that flags 
func attack_queue_expired():
	print("attack_expired")
	attack_queued = false
