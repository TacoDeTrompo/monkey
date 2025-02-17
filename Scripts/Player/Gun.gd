extends Node2D

const BULLET = preload("res://Scenes/Bullet.tscn")
@export var enemy: bool = false # if true, this bullet was spawned by an enemy
var player
#signal givePlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enemy:
		pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !enemy:
		look_at(get_global_mouse_position())
	else:
		look_at(player.global_position)
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
 
	if !enemy:
		if Input.is_action_just_pressed("shoot"):
			var bullet_instance = BULLET.instantiate()
			bullet_instance.global_position = global_position
			bullet_instance.rotation = global_rotation
			bullet_instance.enemy = enemy
			get_tree().root.add_child(bullet_instance)
	else:
		pass

func shoot():
	var bullet_instance = BULLET.instantiate()
	bullet_instance.global_position = global_position
	bullet_instance.rotation = global_rotation
	bullet_instance.enemy = enemy
	get_tree().root.add_child(bullet_instance)
	print("Bam!")
