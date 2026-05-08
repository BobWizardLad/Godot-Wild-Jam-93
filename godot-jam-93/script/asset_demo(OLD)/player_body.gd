class_name PlayerBody
extends CharacterBody2D

const SPEED: float = 100.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	# Get axis input
	direction.x = Input.get_axis("player_left", "player_right")
	direction.y = Input.get_axis("player_up", "player_down")
	
	# Define player move direction normal vector
	direction = direction.normalized()
	velocity = direction * SPEED
	
	# Move and Slide and Reset
	move_and_slide()
	direction = Vector2.ZERO
