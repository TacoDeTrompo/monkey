extends Control

@onready var main = $"../../" #busca el nodo root de la escena. 



func _on_quit_pressed():
	print("off")
	get_tree().quit()


func _on_resume_pressed():
	print("Continue")
	main.pauseMenu() #accede la funcion del menu de pause en el arbol dentro de la escena
