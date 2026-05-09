extends CharacterBody2D

## Bullet lifetime is assigned at bullet instantiation;
## Otherwise bullet has no lifetime (won't fire)
var lifetime: float = 0.0
var muzzle_velocity: Vector2

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var lifetimer: Timer = $LifetimeTimer

func _ready():
	assert(muzzle_velocity != Vector2.ZERO, "Bullet muzzle velocity is zero!")
	velocity = muzzle_velocity
	expire_timer_start(lifetime)

func _physics_process(delta: float):
	move_and_slide()
	if get_slide_collision_count() > 0:
		collide_and_expire(self)

func expire_timer_start(time: float):
	lifetimer.timeout.connect(expire)
	lifetimer.start(lifetime)

## (.(
func collide_and_expire(_body: Node2D):
	if $DamageArea != null:
		$DamageArea.queue_free()
		velocity = velocity * Vector2(0.25, 0.25)
		lifetimer.stop()
		animation_player.play("expire")
	
func expire():
	queue_free()
