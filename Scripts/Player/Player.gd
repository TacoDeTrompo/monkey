extends CharacterBody2D
class_name PlayerBody2D

@export var start_audio_player: AudioStreamPlayer2D
@export var loop_audio_player: AudioStreamPlayer2D
@export var player_state_machine: PlayerStateMachine

var bananas = 0
var money = 10
var oxygen = 100

var stealing_count = 0

var current_pitch = 0.5

# Aim
# var cross = load("res://cross.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Changes a specific shape of the cursor (here, the cross shape).
	# Input.set_custom_mouse_cursor(cross, Input.CURSOR_CROSS)
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	start_audio_player.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	calculate_audio_pitch(delta)
	
	if bananas >= 5:
		# Win
		pass
	
	if money <= 0:
		# Something?
		money = 0
		pass
	
	if oxygen <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
		oxygen = 0
		pass
		
	# is this the correct place to remove oxygen?
	oxygen -= delta
	
	pass

func _on_start_audio_player_finished() -> void:
	loop_audio_player.play()
	pass # Replace with function body.

func calculate_audio_pitch(delta):
	if money > 0: current_pitch += delta
	
	if current_pitch >= 0.7: 
		current_pitch = 0.7
	
	# currently speed goes from 1200 to 0, knowing this we will simple divide it and add that to a base value
	if money > 0:
		current_pitch += velocity.length()/1200
	
	if money <= 0:
		current_pitch -= delta/4
	
	
	start_audio_player.pitch_scale = current_pitch
	loop_audio_player.pitch_scale = current_pitch
	pass

func spawn_police():
	stealing_count+=1
	var police_to_spawn = stealing_count * 2
	# TODO: spawn logic
	pass
