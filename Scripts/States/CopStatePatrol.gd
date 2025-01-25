extends CopState
class_name CopStatePatrol

func Enter():
	#player = get_tree().get_first_node_in_group("Player")
	pass

func Physics_Update(delta):
	#var direction= player.global_position - cop.global_position
	#
	#if direction.length() < 150:
		#Transitioned.emit(self, "Pursue")
	pass

func Exit():
	#Turn alarm on
	pass
