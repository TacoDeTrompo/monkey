extends State

var currentGameState: State
var cost: int
@export var sfx_angry: AudioStreamPlayer
@export var sfx_success: AudioStreamPlayer
@export var brokerSprite: AnimatedSprite2D
@export var rootNode: SubScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	cost = rng.randi_range(1000, 50000)
	currentGameState = rootNode.mainGameStateMachine.current_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rootNode.name == "Stealing":
		sfx_angry.play()
	if rootNode.name == "Broker":
		if rootNode.playerNode.money < cost:
			rootNode.get_node("NotEnough").visible = true
		else:
			var format_string: String = "$%10.2f"
			rootNode.get_node("Cost/Label").text = format_string % cost
			rootNode.get_node("Buy").visible = true
			if Input.is_action_pressed("brake"):
				brokerSprite.set_animation("bought")
				rootNode.playerNode.money -= cost
				for child in rootNode.get_children():	
					if child.name == "Banana":
						child.visible = false
					if child.name == "Banana2":
						child.visible = true
				sfx_success.play()
	if currentGameState.name == "Drive":
		if rootNode.name == "Broker":
			brokerSprite.set_animation("selling")
			var rng = RandomNumberGenerator.new()
			cost = rng.randi_range(1000, 50000)
			for child in rootNode.get_children():
				if child.name == "Banana":
					child.visible = true
				if child.name == "Banana2":
					child.visible = false

func _on_angry_noises_finished() -> void:
	if rootNode.name == "Stealing":
		rootNode.playerNode.money += 10000
		get_parent().on_child_transition(self, "SlidingOut")


func _on_success_noises_finished() -> void:
	if rootNode.name == "Broker":
		get_parent().on_child_transition(self, "SlidingOut")
