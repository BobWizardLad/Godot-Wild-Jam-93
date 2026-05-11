class_name EndlessGameManager
extends Node

var points: int
var wave_count: int

signal points_changed(value: int)
signal wave_count_changed(value: int)

func _ready():
	get_tree().paused = false

func update_points(value: int):
	points += value
	points_changed.emit(points)

func update_wave_count(value: int):
	wave_count += value
	wave_count_changed.emit(wave_count)

func process_game_over() -> void:
	get_tree().paused = true
