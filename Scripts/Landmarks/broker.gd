extends Sprite2D
class_name Broker
var banana = true
@export var cost = 300
@export var game_state_machine: StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		game_state_machine.on_child_transition(game_state_machine.current_state, "Shop")
		#Habilitar el ui de compra al jugador
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		print("Bye~")
		#Deshabilitar UI de compra
	pass # Replace with function body.

func buyBanana(currentMoney:int):
	if currentMoney >= cost and banana:
		banana = false
		#queue_free()
		currentMoney -= cost
		return currentMoney
	else:
		print("You need more money!")
		return currentMoney

func getCost():
	return cost
