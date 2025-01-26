extends StaticBody2D
class_name Shop
var canRob = true
@export var money = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player")  and canRob:
		rob()
		#Dar dinero al jugador o al gamemode/mapa
	pass # Replace with function body.


func _on_rob_cooldown_timeout():
	canRob = true
	pass # Replace with function body.

func can_be_robbed():
	return canRob

func set_robbed(rob):
	canRob = rob

func rob():
	if canRob:
		print("Here comes the money~")
		canRob  = false
		$RobCooldown.start()
		return money
	else:
		print("We dont have any money!")
		return 0
