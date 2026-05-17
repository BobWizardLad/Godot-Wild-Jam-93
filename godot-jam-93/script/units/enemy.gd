class_name Enemy
extends Unit

@onready var soft_animation_player: AnimationPlayer = $SoftAnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavAgent
@onready var animation_blender: AnimationBlender = $EnemyAnimationBlender

@export var nav_target: Node2D

@export var damage: int

var damage_area: DamageArea

signal pickup_holder_died(position: Vector2)

# Move towards the player
# attack the player (move into them, then stop for a short time)

func _ready() -> void:
	super()
	
	add_to_group("Enemy", true)
	if nav_target:
		nav_agent.target_position = nav_target.global_position
	else:
		nav_target = self
		nav_agent.target_position = nav_target.global_position

func _process(_delta: float) -> void:
	if current_health <= 0:
		is_dead = true

func _physics_process(_delta: float) -> void:
	super(_delta)
	if not (self is Gunner):
		animation_blender.update_animation_parameters(self)

## Function that returns the calculated velocity of a unit.
func derive_unit_velocity() -> Vector2:
	#nav_agent.target_position = get_tree().get_first_node_in_group("Player").global_position
	var new_velocity: Vector2
	
	if is_dead:
		return Vector2.ZERO
	if !nav_agent.is_target_reached():
		var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()
		new_velocity = nav_point_direction * SPEED
	else:
		new_velocity = Vector2.ZERO
	
	if velocity != Vector2.ZERO:
		direction = capture_direction(velocity.x, velocity.y)
	
	return new_velocity

func take_damage(value: int, source: Node2D = self, heavy_strike: bool = false):
	super(value, source, heavy_strike)
	soft_animation_player.play("damage")

func die() -> void:
	pickup_holder_died.emit(global_position)
	super()

func _on_pathfinder_timer_timeout() -> void:
	if nav_agent.target_position != nav_target.global_position:
		nav_agent.target_position = nav_target.global_position
	$PathfinderTimer.start()
