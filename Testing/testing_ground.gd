extends Node2D

var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_just_pressed("pause"):
		#pauseMenu()
		#pass
	pass

func pauseMenu():
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#pause_menu.hide()
		$Camera2D/PauseMenu.visible = false
		#Engine.time_scale = 1
		get_tree().paused = false
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#pause_menu.show()
		$Camera2D/PauseMenu.visible = true
		#Engine.time_scale = 0
		get_tree().paused = true
	
	paused = !paused
