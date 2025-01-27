extends "res://State_Machine.gd"
class_name PlayerStateMachine

@export var PlayerNode: PlayerBody2D
@export var PhysicsData: PlayerPhysicsData

var wheel_base = 80 #each wheel is 80 units from the center
var steering_angle = 25
var engine_power = 2600
var friction = -0.9
var drag = -0.001
var braking = -1600
var max_reverse_speed = 500
var slip_speed = 800
var traction_fast = 0.05
var traction_slow = 0.7

var acceleration = Vector2.ZERO
var steer_direction = 0

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input(delta)
	apply_friction()
	calculate_steering(delta)
	PlayerNode.velocity += acceleration * delta
	
	PlayerNode.move_and_slide()

func get_input(delta):
	var usedGas = false
	
	var turn = 0
	if Input.is_action_pressed("right"): 
		turn +=1
	if Input.is_action_pressed("left"): 
		turn -=1
	steer_direction = turn * deg_to_rad(steering_angle)
	#velocity = Vector2.ZERO
	if Input.is_action_pressed("accelerate") && PlayerNode.money > 0:
		usedGas = true
		acceleration = PlayerNode.transform.x * engine_power
	if Input.is_action_pressed("brake") && PlayerNode.money > 0:
		usedGas = true
		acceleration = acceleration + (PlayerNode.transform.x * braking)
	
	if usedGas: PlayerNode.money -= delta * 10 # TODO: is this the proper place to do it?, if accelerating remove money
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
