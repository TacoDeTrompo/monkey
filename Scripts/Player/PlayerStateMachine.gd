extends "res://State_Machine.gd"

@export var PlayerNode: CharacterBody2D
@export var PhysicsData: PlayerPhysicsData

var wheel_base = 80 #each wheel is 80 units from the center
var steering_angle = 25
var engine_power = 800
var friction = -0.9
var drag = -0.001
var braking = -450
var max_reverse_speed = 250
var slip_speed = 400
var traction_fast = 0.05
var traction_slow = 0.7

var acceleration = Vector2.ZERO
var steer_direction = 0

# Aim
# var cross = load("res://cross.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Changes a specific shape of the cursor (here, the cross shape).
	# Input.set_custom_mouse_cursor(cross, Input.CURSOR_CROSS)
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	pass # Replace with function body.

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	PlayerNode.velocity += acceleration * delta
	
	PlayerNode.move_and_slide()

func get_input():
	var turn = 0
	if Input.is_action_pressed("right"): 
		turn +=1
	if Input.is_action_pressed("left"): 
		turn -=1
	steer_direction = turn * deg_to_rad(steering_angle)
	#velocity = Vector2.ZERO
	if Input.is_action_pressed("accelerate"): 
		acceleration = PlayerNode.transform.x * engine_power
	if Input.is_action_pressed("brake"): 
		acceleration = acceleration + (PlayerNode.transform.x * braking)
	pass

func calculate_steering(delta:float):
	var rear_wheel = PlayerNode.position - PlayerNode.transform.x * wheel_base/2.0
	var front_wheel = PlayerNode.position + PlayerNode.transform.x * wheel_base/2.0
	rear_wheel += PlayerNode.velocity * delta
	front_wheel += PlayerNode.velocity.rotated(steer_direction) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if PlayerNode.velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(PlayerNode.velocity.normalized()) #valor entre -1 y 1
	if d > 0:
		PlayerNode.velocity = PlayerNode.velocity.lerp(new_heading * PlayerNode.velocity.length(),traction) 
	elif d < 0:
		PlayerNode.velocity = -new_heading * min( PlayerNode.velocity.length(), max_reverse_speed)
		
	PlayerNode.rotation = new_heading.angle()
		
	pass

func apply_friction():
	if PlayerNode.velocity.length() < 5:
		PlayerNode.velocity = Vector2.ZERO
	var friction_force = PlayerNode.velocity * friction
	var drag_force = PlayerNode.velocity * PlayerNode.velocity.length() * drag
	acceleration += drag_force + friction_force
	pass
