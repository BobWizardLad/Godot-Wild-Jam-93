class_name Striker
extends Enemy

@export var encircle_pattern: Shape2D
@export var stalking_cooldown: float
## Forgiveness for how close to the stalking radius a striker has to be to start attacking the player (0 means the striker *may* not attack the player)
@export var radius_attack_range: float
@export var attack_cooldown_time: float

@onready var attack_area: StrikeArea = $StrikeArea
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var stalking_cooldown_timer: Timer = $StalkingAttemptCooldown

## Flag for if the striker is attempting to move into attack range WARNING UNUSED
var is_attack_moving: bool
## Flag for if the striker is not actively moving for an attack
var is_stalking: bool

func _physics_process(_delta: float) -> void:
	if nav_agent.distance_to_target() < attack_area.offset_length * 2.0 && attack_cooldown.is_stopped():
		attack_attempt(to_local(nav_target.global_position))
		# Animate attack etc
	else:
		super(_delta) # move and slide basically; see Enemy ^

func _process(_delta: float) -> void:
	super(_delta)

func reassign_nav_target_attempt(new_target: Vector2) -> void:
	if new_target != nav_agent.target_position:
			nav_agent.target_position = new_target

func attack_attempt(target_direction: Vector2):
	attack_area.start_strike_collision(target_direction)
	is_stalking = true
	stalking_cooldown_timer.start(stalking_cooldown)
	attack_cooldown.start(attack_cooldown_time)

func _on_attack_cooldown_timeout() -> void:
	attack_area.end_strike_collision()

func _on_pathfinder_timer_timeout() -> void:
	if is_stalking:
		if nav_agent.target_position != nav_target.global_position:
			nav_agent.target_position = nav_target.global_position
	else:
		var angle = randf_range(-PI/2 + nav_target.global_position.angle_to(self.global_position), PI/2 + nav_target.global_position.angle_to(self.global_position))
		var radius_target = Vector2(nav_target.global_position.x + encircle_pattern.radius * cos(angle), nav_target.global_position.y + encircle_pattern.radius * sin(angle))
		if nav_agent.target_position != radius_target:
			nav_agent.target_position = radius_target
	$PathfinderTimer.start()

func _on_stalking_attempt_cooldown_timeout() -> void:
	is_stalking = false

func _on_strike_area_strike_connected() -> void:
	is_stalking = false
