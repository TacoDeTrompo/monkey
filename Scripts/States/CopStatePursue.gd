extends CopState
class_name CopStatePursue

func Enter():
	#player = get_tree().get_first_node_in_group("Player")
	pass

func _process(delta):
	DirectionDif = cop.global_transform.y.dot(cop.global_transform.origin.direction_to(player.global_transform.origin))
	ChasePlayer()
	#print(cop.global_transform.y.dot(cop.global_transform.origin.direction_to(player.global_transform.origin)))

func Physics_Update(delta):
	#cop.velocity.x = move_speed
	#var directionToPlayer =( player.position - cop.position).normalized()

	#var targerPosition = ( player.position - cop.position).normalized()
	#var directionToPlayer = cop.position.angle_to(player.position)
	#print()
	
	#var angle = rad_to_deg(directionToPlayer.angle_to())
	
	#var direction= player.global_position - cop.global_position
	#
	#if direction.length() <= 200:
		#cop.velocity = direction.normalized() * move_speed
	#if direction.length() > 200:
		#Transitioned.emit(self, "Patrol")
	pass

func AlongsideTarget():
	var AlingVal = -500
	if DirectionDif < 0.3:
		AlingVal = 500
	AlignTarget(AlingVal)
	#AvoidCollision
	var distance = cop.global_transform.origin.direction_to(player.global_transform.origin)
	if distance <= 500:
		cop.accelerate(AlongsideDif)
	else:
		cop.accelerate(1)


func AlignTarget(offset= 0):
	var OffsetDirection
	if offset == 0:
		#print(0)
		OffsetDirection = DirectionDif #de donde saco esto?
	else:
		var TargetDirection = cop.global_transform.origin.direction_to(player.global_transform.origin)
		OffsetDirection = cop.global_transform.y.dot(TargetDirection)
	cop.steer(OffsetDirection)

func ChasePlayer():
	AlignTarget()
	#AvoidCollision()
	var distance = cop.global_transform.origin.distance_to(player.global_transform.origin)
	if distance < 100 and AlongsideDif > 0:
		#Transitioned.emit(self, "Patrol") #Crear estado para realiniearse?
		pass
	else:
		#print("run")
		cop.accelerate(1)
	

func Exit():
	#Turn alarm off
	pass
