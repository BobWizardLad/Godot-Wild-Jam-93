class_name Charger
extends Enemy

@export var charge_distance: float
@export var charge_speed: float

@onready var charging_timer: Timer = $ChargingTimer

var charge_direction: Vector2
var is_charging: bool = false
@export var is_windup: bool = false

## Function that returns the calculated velocity of a unit.
## Navigates to player, then charges at them
func derive_unit_velocity() -> Vector2:
	
	if is_windup:
		return Vector2.ZERO
	# If already charging, use the charge for velocity
	elif is_charging:
		return charge_direction * charge_speed
	# if close enough to the player, charge at them
	elif nav_agent.distance_to_target() <= charge_distance:
		is_windup = true
		return charge_direction * charge_speed
	else:
		return super()

func _on_charging_timer_timeout() -> void:
	is_charging = false

## Begin charging at the player
func charge() -> void:
	is_windup = false
	is_charging = true
	charge_direction = to_local(nav_agent.get_next_path_position()).normalized()
	charging_timer.start()
