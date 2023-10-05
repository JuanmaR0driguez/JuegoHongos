extends Node

class_name Damageable

@export var health : float = 20
# Called when the node enters the scene tree for the first time.

func hit(damage : int):
	health -= damage
	get_parent().modulate = Color.from_hsv(0,1-health/20,1)
	
func _process(delta):
	if(health <= 0):
		get_parent().get_node("Sprite2D").set_rotation_degrees(180)
		get_parent().stop = true
		
