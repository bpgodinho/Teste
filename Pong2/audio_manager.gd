extends Node

@onready var music_player: AudioStreamPlayer = $music_player
@onready var audio_player: AudioStreamPlayer = $audio_player
var music_volume = 1.0
var sfx_volume = 1.0

#Loads and plays a looping track
func change_music(audio:String) -> void:
	music_player.stream = ResourceLoader.load(audio)
	music_player.play()

#Loads and plays a sounds once
func audio_play(audio:String) -> void:
	audio_player.stream = ResourceLoader.load(audio)
	audio_player.play()
