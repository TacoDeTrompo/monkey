extends CanvasLayer
class_name UIManagment

@export var bananas: Array[TextureRect]
@export var bubbles: Array[TextureRect]
@export var money_label: Label
@export var player: PlayerBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# money
	var format_string = "$%10.2f"
	money_label.text = format_string % player.money
	
	# bananas
	bananas[0].visible = player.bananas>0
	bananas[1].visible = player.bananas>1
	bananas[2].visible = player.bananas>2
	bananas[3].visible = player.bananas>3
	bananas[4].visible = player.bananas>4
	
	# bubbles
	bubbles[0].visible = player.oxygen>0
	bubbles[1].visible = player.oxygen>20
	bubbles[2].visible = player.oxygen>40
	bubbles[3].visible = player.oxygen>60
	bubbles[4].visible = player.oxygen>80

	# testing variables
	#player.oxygen -= delta*2
	#
	#if Input.is_action_just_pressed("right"): 
		#player.bananas += 1
	
	pass
