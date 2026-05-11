class_name Gunner
extends Enemy

@onready var gun_cast: ShapeCast2D = $GunCast
@onready var gun_controller: GunController = $GunController
@onready var sprite_animator: AnimationPlayer = $SpriteAnimator
@onready var sound_sequencer: SoundSequencer2D = $SoundSequencer2D

@export var follow_distance: float

func _physics_process(_delta: float) -> void:
	gun_cast.target_position = to_local(nav_agent.target_position)
	if gun_cast.is_colliding() && gun_cast.get_collider(0) is Player:
		shoot_attack(gun_cast.target_position)
	super(_delta) # move and slide basically; see Enemy ^

## Function that returns the calculated velocity of a unit.
func derive_unit_velocity() -> Vector2:
	if nav_agent.distance_to_target() <= follow_distance && (gun_cast.is_colliding() && gun_cast.get_collider(0) is Player):
		sprite_animator.play("standing")
		return Vector2.ZERO
	else:
		sprite_animator.play("walk")
		return super()

func shoot_attack(target: Vector2) -> void:
	gun_controller.shoot(target)
