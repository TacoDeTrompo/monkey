extends CanvasLayer
class_name UIManagment

@export var bananas: Array[TextureRect]
@export var bubbles: Array[TextureRect]
@export var money_label: Label
@export var player: PlayerBody2D

@export var monkey_mirror: AnimatedSprite2D
@export var mirror_holder: Node2D

var mirror_tilt = 0

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

	#testing variables
	#player.oxygen -= delta*2
	#
	#if Input.is_action_just_pressed("right"): 
		#player.bananas += 1
		
	handing_mirror(delta)
	
	pass

func handing_mirror(delta):
	#animation
	var return_to_standard = true
	if(player.money > 10000):
		return_to_standard = false
		if(monkey_mirror.animation!="money"):
			monkey_mirror.set_animation("money")
	# TODO: get the police count based on children in a node
	if(false):
		return_to_standard = false
		if(monkey_mirror.animation!="chase"):
			monkey_mirror.set_animation("chase")
	
	if(return_to_standard && monkey_mirror.animation!="standard"): monkey_mirror.set_animation("standard")
	
	#tilt
	var turn = 0
	if Input.is_action_pressed("right"): 
		turn +=1
	if Input.is_action_pressed("left"): 
		turn -=1
	
	# Add direction
	mirror_tilt += turn*delta*30
	# Make the mirror return to 0
	mirror_tilt -= sign(mirror_tilt) * delta * 10
	
	
	if(mirror_tilt >= 20): mirror_tilt = 20
	if(mirror_tilt <= -20): mirror_tilt = -20
	
	# Add noice
	mirror_tilt += randf_range(-0.5, 0.5) * delta * (80 * player.velocity.length()/1200)
	mirror_holder.rotation_degrees = mirror_tilt

	pass
