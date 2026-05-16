class_name HealthDisplay
extends Control

@onready var health_bar: TextureProgressBar = $HealthBar

func update_health_bar(value: float) -> void:
	health_bar.value = value

func update_health_bar_max(max_value: float) -> void:
	health_bar.max_value = max_value
