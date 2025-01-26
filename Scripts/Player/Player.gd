extends CharacterBody2D
class_name PlayerBody2D

@export var start_audio_player: AudioStreamPlayer2D
@export var loop_audio_player: AudioStreamPlayer2D
@export var player_state_machine: PlayerStateMachine
@onready var police = preload("res://Characters/police.tscn")

var bananas = 0
var money = 50
var oxygen = 100

var current_pitch = 0.5
var current_steal = 0

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

func spawnCops():
	var n = 0
	current_steal += 1
	#while n < current_steal:
		#n+=1
	print("POLICIA!!!!")
	var cop = police.instantiate()
	var copSpawn: Vector2 = Vector2.ZERO
	var spawnPos =  randf_range(-1000, 1000)
	if spawnPos > 0: 
		spawnPos +=1500
	else:
		spawnPos -=1500
	copSpawn.x = position.x + spawnPos

	spawnPos =  randf_range(-1000, 1000)
	if spawnPos > 0: 
		spawnPos +=1500
	else:
		spawnPos -=1500
	copSpawn.y = position.y + spawnPos
	
	cop.position = copSpawn
	get_parent().add_child(cop)

func take_money_damage():
	print("My dinero!")
	money -= 100
