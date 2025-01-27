extends GameState
class_name Drive


@export var music_manager: MusicManager


func Enter():
	super()
	state_name = "Drive"
	get_tree().paused = false
	music_manager.StartAudioStreamPlay("PersecusionIntro")
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func Update():
	#main process of the game
	pass
