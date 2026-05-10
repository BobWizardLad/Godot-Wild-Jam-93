class_name Player
extends Unit

@export var dash_speed: float
@export var dash_cooldown_time: float
@onready var dash_cooldown: Timer = $DashCooldown
var is_dashing: bool = false
var dash_direction: Vector2

@onready var animation_blender: AnimationBlender = $MovementBlender
@onready var cursor: Cursor = $Cursor
@onready var gun_controller: GunController = $GunController
@onready var health_display: HealthDisplay = $HealthDisplay

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	velocity = derive_unit_velocity()
	animation_blender.update_animation_parameters(self)
	if is_forced_moving:
		pass
	else:
		move_and_slide()

func _process(delta: float) -> void:
	health_display.update_health_bar(current_health)
	if current_health == 0:
		pass # Do player death stuff

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") && !is_dashing && direction != Vector2.ZERO:
		dash_movement()
	if event.is_action_pressed("shoot"):
		shoot_attack(cursor.get_target())

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
	is_dashing = true
	dash_direction = direction.normalized()
	animation_blender.animate_dodge()

func shoot_attack(target: Vector2) -> void:
	gun_controller.shoot(target)

func _on_dash_cooldown_timeout() -> void:
	is_dashing = false
