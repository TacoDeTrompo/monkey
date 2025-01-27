extends Node
class_name MusicLayerManager


@export var dynamicLayers: Array[AudioStreamPlayer]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is AudioStreamPlayer:
			dynamicLayers.append(child)
			
		
func startAudioStreamPlay() -> void:
	for layer in dynamicLayers:
		layer.play()
			
		
func enableLayerStreamPlay(layerName: String) -> void:
	for layer in dynamicLayers:
		if layer.name == layerName:
			layer.set_volume_db(0.0)
			
		
func disableLayerStreamPlay(layerName: String) -> void:
	for layer in dynamicLayers:
		if layer.name == layerName:
			layer.set_volume_db(-80.0)
			
		
func stopAllLayers():
	for layer in dynamicLayers:
		layer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_persecusion_intro_finished() -> void:
	startAudioStreamPlay()
