class_name Player
extends Unit

@export var dash_distance: float
@export var dash_time: float
@export var dash_cooldown_time: float
@onready var dash_cooldown: Timer = $DashCooldown

@onready var animation_blender: AnimationBlender = $MovementBlender
@onready var cursor: Cursor = $Cursor

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	velocity = derive_unit_velocity()
	if is_forced_moving:
		pass
	else:
		move_and_slide()

func _process(delta: float) -> void:
	animation_blender.update_animation_parameters(self)
	if current_health == 0:
		pass # Do player death stuff

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") && dash_cooldown.is_stopped() && direction != Vector2.ZERO:
		dash_movement(direction)
	if event.is_action_pressed("shoot"):
		print(cursor.get_target())

## Function that returns the calculated velocity of a unit.
func derive_unit_velocity() -> Vector2:
	# Get axis input
	var input_dir: Vector2 
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir.y = Input.get_axis("move_up", "move_down")
	
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
