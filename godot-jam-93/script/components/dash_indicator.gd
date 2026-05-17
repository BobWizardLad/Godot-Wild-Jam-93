class_name DashIndicator
extends TextureProgressBar
## Class for the dash indicator that hides this when not in use, and
## constantly displays the time remaining in the dash cooldown timer to the player

@export var dash_cooldown_timer: Timer

func _ready():
	dash_cooldown_timer.timeout.connect(cooldown_timer_ended)
	
	min_value = 0

func _process(delta: float) -> void:
	print(dash_cooldown_timer.time_left)
	value = dash_cooldown_timer.time_left

func cooldown_timer_started():
	max_value = dash_cooldown_timer.wait_time
	value = dash_cooldown_timer.time_left
	show()

func cooldown_timer_ended():
	hide()
