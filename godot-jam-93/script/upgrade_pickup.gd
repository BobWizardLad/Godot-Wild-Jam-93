extends Pickup

@export_range(0, 2) var type: int 

func handle_detected_body(body: Player):
	body.roll_upgrade(type)
