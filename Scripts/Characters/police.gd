extends CharacterBody2D
class_name Police
@export var player:CharacterBody2D
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
var wheel_base = 70 #distancia entre las llantas
var steering_angle = 25 #que tanto gira el auto/rueda
var engine_power = 2200
var friction = -0.9
var drag = -0.001
var braking = -450
var max_reverse_speed = 250
var slip_speed = 400
var traction_fast = 0.05
var traction_slow = 0.7

var acceleration = Vector2.ZERO
var steer_direction = 0
var DirectionDif = 0
var AlongsideDif = 0

var reloading: bool = false

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	#$Gun.givePlayer.connect(aim_at_player)
	$Gun.player = player
	pass

func _physics_process(delta):
	acceleration = Vector2.ZERO
	#get_input()
	DirectionDif = global_transform.y.dot(global_transform.origin.direction_to(player.global_transform.origin))
	ChasePlayer()
	#print(global_transform.y.dot(global_transform.origin.direction_to(player.global_transform.origin)))
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


func steer(turn):
	steer_direction = turn * deg_to_rad(steering_angle)
	pass

func accelerate(power):
	if power > 0: 
		acceleration = (transform.x * engine_power) * power
	if power < 0: 
		acceleration = -((transform.x * braking) * power)
	pass

func get_input():
	var turn = 0
	if Input.is_action_pressed("ui_right"): 
		turn +=1
	if Input.is_action_pressed("ui_left"): 
		turn -=1
	steer(turn)
	
	#steer_direction = turn * deg_to_rad(steering_angle)
	#velocity = Vector2.ZERO
	#if Input.is_action_pressed("ui_up"): 
		#acceleration = transform.x * engine_power
	#if Input.is_action_pressed("ui_down"): 
		#acceleration = transform.x * braking
		
	if Input.is_action_pressed("ui_up"): 
		accelerate(1)
	if Input.is_action_pressed("ui_down"): 
		accelerate(-1)
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

func AlongsideTarget():
	var AlingVal = -500
	if DirectionDif < 0.3:
		AlingVal = 500
	AlignTarget(AlingVal)
	#AvoidCollision
	var distance = global_transform.origin.direction_to(player.global_transform.origin)
	if distance <= 500:
		accelerate(AlongsideDif)
	else:
		accelerate(1)


func AlignTarget(offset= 0):
	var OffsetDirection
	if offset == 0:
		OffsetDirection = DirectionDif #de donde saco esto?
	else:
		var TargetDirection = global_transform.origin.direction_to(player.global_transform.origin)
		OffsetDirection = global_transform.y.dot(TargetDirection)
	steer(OffsetDirection)

func ChasePlayer():
	AlignTarget()
	#AvoidCollision()
	var distance = global_transform.origin.distance_to(player.global_transform.origin)
	#if distance < 200 and AlongsideDif > 0:
	if distance < 1000 and reloading == false:
		print("suck on this!!!")
		$Gun.shoot()
		reloading = true;
		$Shot_Cooldown.start()
	if distance < 500:
		#$Gun.shoot()
		#Transitioned.emit(self, "Patrol") #Crear estado para realiniearse?
		pass
	else:
		accelerate(1)


func _on_shot_cooldown_timeout():
	reloading = false
	pass # Replace with function body.

func retire():
	queue_free()
