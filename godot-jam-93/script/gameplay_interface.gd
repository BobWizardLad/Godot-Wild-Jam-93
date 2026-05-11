class_name EndlessGameplayInterface
extends Control

@onready var points: Label = $MarginContainer/VBoxContainer/HBoxContainer/Points
@onready var wave_number: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Wave

func update_points(value: int) -> void:
	points.text = str(value)

func update_wave_count(value: int) -> void:
	wave_number.text = str(value)
