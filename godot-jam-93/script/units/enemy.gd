class_name Enemy
extends Unit

@onready var soft_animation_player: AnimationPlayer = $SoftAnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavAgent

@export var nav_target: Node2D

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
		pickup_holder_died.emit(global_position)
		die()

func _physics_process(_delta: float) -> void:
	super(_delta)

## Function that returns the calculated velocity of a unit.
func derive_unit_velocity() -> Vector2:
	#nav_agent.target_position = get_tree().get_first_node_in_group("Player").global_position
	if !nav_agent.is_target_reached():
		var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()
		return nav_point_direction * SPEED
	else:
		return Vector2.ZERO

func take_damage(value: int, source: Node2D = self, heavy_strike: bool = false):
	super(value, source, heavy_strike)
	soft_animation_player.play("damage")

func _on_pathfinder_timer_timeout() -> void:
	if nav_agent.target_position != nav_target.global_position:
		nav_agent.target_position = nav_target.global_position
	$PathfinderTimer.start()
