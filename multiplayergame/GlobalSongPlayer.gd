extends Node

var music_player: AudioStreamPlayer

func _ready():
	# Create an AudioStreamPlayer node and add it to this node
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	# Ensure the music player persists
	music_player.stream_paused = false
	music_player.autoplay = false


func play_song(song: AudioStream):
	if music_player.stream != song:
		music_player.stop()  # Stop current song if a different one is playing
		music_player.stream = song
		music_player.play()

func stop_song():
	music_player.stop()

func pause_song():
	music_player.stream_paused = true

func resume_song():
	music_player.stream_paused = false
