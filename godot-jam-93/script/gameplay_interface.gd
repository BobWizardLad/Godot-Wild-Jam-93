class_name EndlessGameplayInterface
extends Control

@onready var points: Label = $MarginContainer/VBoxContainer/HBoxContainer/Points
@onready var wave_number: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Wave
@onready var game_over: Label = $YouDied

@onready var interface_player: AnimationPlayer = $InterfacePlayer

func update_points(value: int) -> void:
	points.text = str(value)

func update_wave_count(value: int) -> void:
	wave_number.text = str(value)

func trigger_game_over() -> void:
	interface_player.play("you_died")

func trigger_wave_clear_msg() -> void:
	interface_player.play("wave_clear")

func trigger_wave_start_msg() -> void:
	interface_player.play("wave_start")
