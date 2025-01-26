extends Node
var scene = preload("res://Landmarks/bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnCooldown.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SpawnBubble():
	if get_child_count() <= 2:
		
		var scene_instance = scene.instantiate()
		scene_instance.set_name("scene")
		add_child(scene_instance)
		print("Blup")
	else:
		$SpawnCooldown.start()
	pass


func _on_spawn_cooldown_timeout():
	SpawnBubble()
	$SpawnCooldown.start()
	pass # Replace with function body.
