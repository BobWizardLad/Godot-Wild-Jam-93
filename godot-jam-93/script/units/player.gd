class_name Player
extends Unit

@export var upgrade_tree_controller: UpgradeTreeController
@export var inventory: Inventory
@export var player_debug: bool

@export_group("Gun Stats")
var bullet_speed: float
@export var bullet_speed_base: float
var fire_cooldown: float
@export var fire_cooldown_base: float
var bullet_damage: int
@export var bullet_damage_base: int
var bullet_is_heavy_strike: bool
@export var bullet_is_heavy_strike_base: bool

@export_group("Dashing")
var dash_speed: float
@export var dash_speed_base: float
var dash_duration_time: float
@export var dash_duration_time_base: float
var dash_cooldown_time: float
@export var dash_cooldown_time_base: float

@export_group("Core Stat Bases")
@export var speed_base: float
@export var max_health_base: int

@onready var dash_cooldown: Timer = $DashCooldown
@onready var dash_duration: Timer = $DashDuration
var is_dashing: bool = false
var dash_direction: Vector2

@export_group("Sound FX")
@export var sfx_damage: AudioStream

@onready var animation_blender: AnimationBlender = $MovementBlender
@onready var cursor: Cursor = $Cursor
@onready var gun_controller: GunController = $GunController
@onready var health_display: HealthDisplay = $HealthDisplay
@onready var sound_sequencer: SoundSequencer2D = $SoundSequencer2D

func _ready() -> void:
	if !player_debug:
		assert(upgrade_tree_controller != null, "No Upgrade Tree Controller pointed to in Player!")
		assert(inventory != null, "No Inventory Node pointed to in Player!")
		upgrade_tree_controller.apply_upgrades_in_tree(self)
		upgrade_tree_controller.upgrade_tree_modified.connect(_on_upgrade_tree_modified)
	
	super()
	reset_player_stats()
	

func _physics_process(_delta: float) -> void:
	super(_delta)
	animation_blender.update_animation_parameters(self)

func _process(delta: float) -> void:
	health_display.update_health_bar(current_health)
	if current_health == 0:
		player_death_sequence()
	if Input.is_action_pressed("shoot"):
		shoot_attack(cursor.get_target())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") && dash_cooldown.is_stopped() && direction != Vector2.ZERO:
		dash_movement()

## Resets all stats of the player to their defined base stats
## Resets their values to what they were at scene instantiation before upgrades
func reset_player_stats() -> void:
	var percent_health = float(current_health) / max_health
	
	bullet_speed = bullet_speed_base
	fire_cooldown = fire_cooldown_base
	bullet_damage = bullet_damage_base
	bullet_is_heavy_strike = bullet_is_heavy_strike_base
	dash_speed = dash_speed_base
	dash_duration_time = dash_duration_time_base
	dash_cooldown_time = dash_cooldown_time_base
	SPEED = speed_base
	max_health = max_health_base
	current_health = max_health * percent_health
	

func take_damage(value: int, source: Node2D = self, heavy_strike: bool = false):
	if is_invincible:
		damage_stopped.emit()
	else:
		current_health -= value
		sound_sequencer._queue_audio_track(sfx_damage)
		damage_taken.emit(value)
		if current_health > max_health:
			current_health = max_health
		if current_health <= 0:
			current_health = 0
		if heavy_strike:
			forced_move(-1 * global_position.direction_to(source.global_position), 115.0, 0.3)
		health_recalculated.emit(current_health)

## Function that returns the calculated velocity of a unit.
func derive_unit_velocity() -> Vector2:
	# Get axis input
	var input_dir: Vector2 
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir.y = Input.get_axis("move_up", "move_down")
	
	if input_dir != Vector2.ZERO:
		direction = capture_direction(input_dir.x, input_dir.y)
	
	# Dash movement check
	if is_dashing:
		return dash_direction * dash_speed
	else:
		return input_dir.normalized() * SPEED

## initiate a dash for the player; This will change the velocity calculation to a fixed value based on the player's
## state when dash is pressed.
func dash_movement():
	dash_cooldown.start(dash_cooldown_time)
	dash_duration.start(dash_duration_time)
	is_dashing = true
	dash_direction = direction.normalized()
	animation_blender.animate_dodge()

func shoot_attack(target: Vector2) -> void:
	gun_controller.shoot(target)

func player_death_sequence() -> void:
	died.emit()

func _on_upgrade_tree_modified() -> void:
	reset_player_stats()
	upgrade_tree_controller.apply_upgrades_in_tree(self)

func _on_dash_duration_timeout() -> void:
	is_dashing = false
