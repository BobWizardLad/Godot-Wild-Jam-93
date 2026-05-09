class_name Striker
extends Enemy

@onready var attack_area: StrikeArea = $StrikeArea
@onready var attack_cooldown: Timer = $AttackCooldown

func _physics_process(_delta: float) -> void:
	if nav_agent.distance_to_target() < attack_area.offset_length * 2.0 && attack_cooldown.is_stopped():
		attack_attempt(to_local(nav_agent.target_position))
		# Animate attack etc
	else:
		super(_delta) # move and slide basically; see Enemy ^

func attack_attempt(target_direction: Vector2):
	attack_area.start_strike_collision(target_direction)
	attack_cooldown.start()

func _on_attack_cooldown_timeout() -> void:
	attack_area.end_strike_collision()
