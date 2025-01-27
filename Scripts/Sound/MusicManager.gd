extends Node
class_name MusicManager


@export var songs: Array[AudioStreamPlayer]
@export var layeredSong: MusicLayerManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is AudioStreamPlayer:
			songs.append(child)
			
		
func StartAudioStreamPlay(songName: String):
	for song in songs:
		if song.is_playing():
			song.stop()
			layeredSong.stopAllLayers()
		if song.name == songName:
			song.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
