extends CharacterBody2D


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
var wheel_base = 70 #distancia entre las llantas
var steering_angle = 25 #que tanto gira el auto/rueda
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

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#velocity.x =  SPEED
	
	move_and_slide()


func get_input():
	var turn = 0
	if Input.is_action_pressed("ui_right"): 
		turn +=1
	if Input.is_action_pressed("ui_left"): 
		turn -=1
	steer_direction = turn * deg_to_rad(steering_angle)
	#velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"): 
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("ui_down"): 
		acceleration = transform.x * braking
	pass

func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/2.0
	var front_wheel = position + transform.x * wheel_base/2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized()) #valor entre -1 y 1
	if d > 0:
		velocity = velocity.lerp(new_heading * velocity.length(),traction) 
	elif d < 0:
		velocity = -new_heading * min( velocity.length(), max_reverse_speed)
	rotation = new_heading.angle()
		
	pass

func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force
	pass
