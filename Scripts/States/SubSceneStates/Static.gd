extends State

var currentGameState: GameState
var cost: int
@export var sfx_angry: AudioStreamPlayer
@export var sfx_success: AudioStreamPlayer
@export var brokerSprite: AnimatedSprite2D
@export var rootNode: SubScene
@export var notenough: Sprite2D
@export var buy: Sprite2D
@export var banana: AnimatedSprite2D
@export var banana2: AnimatedSprite2D
@export var moneyLabel: Label
var sfx_angry_played: bool = false
var sfx_success_played: bool = false
var bought: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_of_state = "Static"
	var rng = RandomNumberGenerator.new()
	cost = rng.randi_range(1000, 50000)
	#cost = 2
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currentGameState = rootNode.mainGameStateMachine.current_state
	if currentGameState != null:
		if currentGameState.state_name != "Drive":
			if currentGameState.state_name == "Steal":
				if sfx_angry.is_playing() == false and sfx_angry_played == false:
					sfx_angry_played = true
					sfx_angry.play()
			if currentGameState.state_name == "Shop":
				if moneyLabel != null:
					var format_string: String = "$%10.2f"
					moneyLabel.text = format_string % cost
				if rootNode.playerNode.money < cost and bought == false:
					if notenough != null:
						notenough.visible = true
					if sfx_angry.is_playing() == false and sfx_angry_played == false:
						sfx_angry_played = true
						sfx_angry.play()
				else:
					bought = true
					if buy != null:
						buy.visible = true
					if Input.is_action_pressed("brake"):
						if buy != null:
							brokerSprite.set_animation("bought")
						for child in rootNode.get_children():	
							if child.name == "Banana":
								child.visible = false
							if child.name == "Banana2":
								child.visible = true
						if sfx_success != null:
							if sfx_success.is_playing() == false and sfx_success_played == false:
								sfx_success_played = true
								sfx_success.play()
		if currentGameState.state_name == "Drive":
			if currentGameState.state_name == "Shop":
				if buy != null:
					buy.visible = false
				brokerSprite.set_animation("selling")
				var rng = RandomNumberGenerator.new()
				cost = rng.randi_range(1000, 50000)
				for child in rootNode.get_children():
					if child.name == "Banana":
						child.visible = true
					if child.name == "Banana2":
						child.visible = false

func _on_angry_noises_finished() -> void:
	if currentGameState.state_name == "Steal":
		rootNode.playerNode.money += 5000
	else:
		if notenough != null:
			notenough.visible = false
	sfx_angry_played = false
	get_parent().on_child_transition(self, "SlidingOut")


func _on_success_noises_finished() -> void:
	if rootNode.name == "Broker":
		sfx_success_played = false
		rootNode.playerNode.money -= cost
		rootNode.playerNode.bananas += 1
		rootNode.banana_bought.emit()
		get_parent().on_child_transition(self, "SlidingOut")
		bought = true
