extends StaticBody2D

var canRob = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player")  and canRob:
		print("Here comes the money~")
		canRob  = false
		$RobCooldown.start()
		#Dar dinero al jugador o al gamemode/mapa
	pass # Replace with function body.


func _on_rob_cooldown_timeout():
	canRob = true
	pass # Replace with function body.
