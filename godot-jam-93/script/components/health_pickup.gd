extends Pickup

@export var healing_value: int

func handle_detected_body(body: Player):
	body.current_health += healing_value
	queue_free()
