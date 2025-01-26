extends State

@export var parentSubScene: SubScene
var pathFollow2D: PathFollow2D

const MAX_SPEED: float    = 0.7
const ACCELERATION: float = 0.3
const DECELERATION: float = 0.1
var speed: float   = 1.0
var progress: float = 0.0
var finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathFollow2D = parentSubScene.pathFollow2D
	
	
func accelerate(_delta:float):
	if speed < MAX_SPEED:
		speed += ACCELERATION * _delta 


func decelarate(_delta:float):
	if progress < 0.991:
		speed -= DECELERATION * _delta
	else:
		speed -= 0.6 * _delta
		finished = true
		

func Update():
	if progress <= 0.991 && finished == true:
		get_parent().on_child_transition(self, "Static")


func Physics_Update(_delta:float):
	print(speed)
	if progress >= 1.0:
		progress = 1.0
		speed = 0.0
	if pathFollow2D.progress_ratio < 0.2 && progress < 1.0:
		accelerate(_delta)
	else:
		decelarate(_delta)
	progress += speed * _delta
	if progress > 1.0:
		progress = 1.0
	if progress <= 0.991 && finished == true:
		progress = 0.991
	pathFollow2D.progress_ratio = progress
