extends Sprite2D
class_name Bubble

@export var oxigen = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	#if body is CharacterBody2D: #debe ser cambiado por la clase de jugador. 
	if body.is_in_group("Player"): #aun conveiene que lo haga clase para acceder a sus funciones o atributos
		print("OH! You got me!")
		body.regain_air()
		queue_free()
		#Activar funcion en jugador
		#queue_free()
	pass # Replace with function body.

func collected():
	queue_free()
