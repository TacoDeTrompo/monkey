extends Node
class_name SubScene

@export var pathFollow2D: PathFollow2D
@export var playerNode: PlayerBody2D
@export var mainGameStateMachine: StateMachine

signal banana_bought

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
