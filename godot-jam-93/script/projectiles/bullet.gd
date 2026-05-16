extends CharacterBody2D

## Bullet lifetime is assigned at bullet instantiation;
## Otherwise bullet has no lifetime (won't fire)
var lifetime: float = 0.0
var muzzle_velocity: Vector2
var damage: int
var is_heavy_strike: bool

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var lifetimer: Timer = $LifetimeTimer
@onready var bullet_area: BulletArea = $BulletArea

func _ready():
	assert(muzzle_velocity != Vector2.ZERO, "Bullet muzzle velocity is zero!")
	expire_timer_start(lifetime)

func _physics_process(_delta: float):
	velocity = muzzle_velocity
	move_and_slide()
	if get_slide_collision_count() > 0:
		collide_and_expire(self)

func expire_timer_start(time: float):
	lifetimer.timeout.connect(collide_and_expire)
	lifetimer.start(time)

## (.(
func collide_and_expire(_body: Node2D = null):
	velocity = velocity * Vector2(0.25, 0.25)
	lifetimer.stop()
	animation_player.play("expire")
	
func expire():
	queue_free()
