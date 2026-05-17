class_name SoundSequencer2D
extends Node2D

## Node that queues positional sound effects at its location up to a number of times, allowing
## layering of the same or different sound effect instances

@export var max_players_per_sound: int
@export var player_volume: float

signal all_players_finished

var active_players: Array[AudioStreamPlayer2D]

func _ready() -> void:
	active_players = []

func _queue_audio_track(track: AudioStream):
	if get_active_players_count(track) < max_players_per_sound:
		create_player_and_play(track)

func get_active_players_count(track: AudioStream) -> int:
	var count = 0
	for each in active_players:
		if each.stream == track:
			count += 1
	return count

func create_player_and_play(track: AudioStream) -> void:
	var player = AudioStreamPlayer2D.new()
	player.stream = track
	player.bus = "SFX"
	player.volume_db = player_volume
	player.finished.connect(cleanup_idle_players)
	active_players.append(player)
	add_child(player)
	player.play()

func cleanup_idle_players() -> void:
	for each in active_players:
		if each.playing == false:
			active_players.erase(each)
			each.queue_free()
	if active_players.size() == 0:
		all_players_finished.emit()
