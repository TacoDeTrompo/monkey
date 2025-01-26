extends State


@export var music_manager: MusicManager
@export var subScene: SubScene


func Enter():
	super()
	music_manager.StartAudioStreamPlay("ShopMusic")
	for child in subScene.get_children():
		if child.name == "StateMachine":
			child.on_child_transition(child.current_state, "SlidingIn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func Update():
	#pause processes from the game overlay smaller canvas with events from broker
	pass