class_name Enemy
extends Unit

@onready var soft_animation_player: AnimationPlayer = $SoftAnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavAgent

# Move towards the player
# attack the player (move into them, then stop for a short time)

func _physics_process(delta: float) -> void:
	pass

func take_damage(value: int, source: Node2D = self, heavy_strike: bool = false):
	super(value, source, heavy_strike)
	soft_animation_player.play("damage")
