extends Node2D

@export var bullet_sprite: Sprite2D
@export var enemey_bullet_texture: Texture2D
@export var player_bullet_texture: Texture2D

const SPEED: int = 2000
var enemy: bool = true
var damage: int = 1

func _ready() -> void:
	if(enemy):
		bullet_sprite.texture = enemey_bullet_texture
	else:
		bullet_sprite.texture = player_bullet_texture
	
	bullet_sprite.visible = true
	pass

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
 
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_bullet_body_entered(body):
	
	if enemy && body.name=="Player":
		collide_with_player(body)
	elif !enemy && body.name!="Player": # Yes, we assume that every body collider that is not the player is an enemy
		collide_with_enemy(body)

func collide_with_enemy(body):
	body.retire()
	print("I hit an enemy!")
	queue_free()
	pass

func collide_with_player(body):
	body.take_money_damage()
	print("I hit the player!")
	queue_free()
	pass
