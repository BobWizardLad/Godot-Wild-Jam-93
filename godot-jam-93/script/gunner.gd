class_name Gunner
extends Enemy

@onready var gun_cast: RayCast2D = $GunCast
@onready var gun_controller: GunController = $GunController

func _physics_process(_delta: float) -> void:
	gun_cast.target_position = to_local(nav_agent.target_position)
	if gun_cast.is_colliding() && gun_cast.get_collider() is Player:
		shoot_attack(gun_cast.target_position)
	super(_delta) # move and slide basically; see Enemy ^

func shoot_attack(target: Vector2) -> void:
	gun_controller.shoot(target)
