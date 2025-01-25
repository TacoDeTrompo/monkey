extends "res://State_Machine.gd"

@export var PlayerNode: CharacterBody2D
@export var PhysicsData: PlayerPhysicsData

var wheel_base = 160 #each wheel is 80 units from the center
var steering_angle = 15

var velocity = Vector2.ZERO
var steer_direction

# Aim
# var cross = load("res://cross.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Changes a specific shape of the cursor (here, the cross shape).
	# Input.set_custom_mouse_cursor(cross, Input.CURSOR_CROSS)
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	pass # Replace with function body.

#TODO: actually do it okey

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var isPressingFwd = 0
	#var isPressingBack = 0
	#var directionAxis = 0
	#
	#if Input.is_action_pressed("accelerate"):
		#isPressingFwd = 1
		#
	#if Input.is_action_pressed("brake"):
		#isPressingBack = 1
		#
	#if isPressingFwd:
		#speed += accel * delta
	#else:
		#if speed > 0:
			#speed -= accel * delta
			#if speed <= 0:
				#speed = 0
		#
	#if isPressingBack:
		#speed -= accel * 0.75 * delta
	#else:
		#if speed < 0:
			#speed += accel * delta
		#
	#
	#if speed > maxSpeed:
		#speed = maxSpeed
	#
	#if speed < maxNegativeSpeed:
		#speed = maxNegativeSpeed
#
	#if Input.is_action_pressed("right"):
		##PlayerNode.rotation_degrees += turnDegree * delta
		#directionAxis += 1
		#
	#if Input.is_action_pressed("left"):
		##PlayerNode.rotation_degrees -= turnDegree * delta
		#directionAxis -= 1
	#
	#var deltaVelocity = (isPressingFwd * speed * delta) - (isPressingBack * brakingPower * delta)
	#
	#var motion_vector = Vector2(0,-deltaVelocity).rotated(PlayerNode.rotation)
	#
	#PlayerNode.velocity += motion_vector
	#
	##print(PlayerNode.velocity.y)
	##print(motion_vector)
	#
	#PlayerNode.move_and_slide()
	
	pass

func _physics_process(delta: float) -> void:
	get_input()
	calculate_steering(delta)
	PlayerNode.move_and_slide()
	pass

func get_input():
	var directionAxis = 0
	
	if Input.is_action_pressed("right"):
		#PlayerNode.rotation_degrees += turnDegree * delta
		directionAxis += 1
	
	if Input.is_action_pressed("left"):
		#PlayerNode.rotation_degrees -= turnDegree * delta
		directionAxis -= 1
	
	steer_direction = directionAxis * deg_to_rad(steering_angle)
	
	velocity = Vector2.ZERO
	if Input.is_action_pressed("accelerate"):
		velocity = PlayerNode.transform.x * 500
	
	pass

func calculate_steering(delta: float):
	var rear_wheel = PlayerNode.position - PlayerNode.transform.x * wheel_base/2.0
	var front_wheel = PlayerNode.position + PlayerNode.transform.x * wheel_base/2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	velocity = new_heading * velocity.length()
	PlayerNode.rotation = new_heading.angle()
	
	PlayerNode.velocity += velocity
	
	pass
 
