extends CopState
class_name CopStatePursue

func Enter():
	#player = get_tree().get_first_node_in_group("Player")
	pass

func Physics_Update(delta):
	cop.velocity.x = move_speed
	
	#var direction= player.global_position - cop.global_position
	#
	#if direction.length() <= 200:
		#cop.velocity = direction.normalized() * move_speed
	#if direction.length() > 200:
		#Transitioned.emit(self, "Patrol")

func Exit():
	#Turn alarm off
	pass
