extends Node

@export var StartAudioPlayer: AudioStreamPlayer2D
@export var LoopAudioPlayer: AudioStreamPlayer2D

# Aim
# var cross = load("res://cross.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Changes a specific shape of the cursor (here, the cross shape).
	# Input.set_custom_mouse_cursor(cross, Input.CURSOR_CROSS)
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	StartAudioPlayer.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
