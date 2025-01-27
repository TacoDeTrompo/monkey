extends State


@export var parentSubScene: SubScene
var pathFollow2D: PathFollow2D

const MAX_SPEED: float    = 0.7
const ACCELERATION: float = 0.3
const DECELERATION: float = 0.1
var speed: float   = 1.0
var progress: float = 1.0
var finished: bool = false
var player

signal police

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_of_state = "SlidingOut"
	pathFollow2D = parentSubScene.pathFollow2D
	player = get_tree().get_first_node_in_group("Player")

func Exit():
	super()
	finished = false
	speed = 1.0
	pathFollow2D.progress_ratio = 0.0
	player.spawnCops()


func accelerate(_delta:float):
	if speed < MAX_SPEED:
		speed += ACCELERATION * _delta


func decelarate(_delta:float):
	speed -= DECELERATION * _delta


func Update():
	if progress <= 0.0:
		pathFollow2D.progress_ratio = 0.0
		get_parent().on_child_transition(self, "Static")
		var currentState: State = parentSubScene.mainGameStateMachine.current_state
		parentSubScene.mainGameStateMachine.on_child_transition(currentState, "Drive")


func Physics_Update(_delta:float):
	if get_parent().current_state.name_of_state == "SlidingOut":
		decelarate(_delta)
		if speed == 0.0:
			speed = 0.0
		progress -= speed * _delta
		if progress <= 0.0:
			progress = 0.0
		pathFollow2D.progress_ratio = progress
