
extends CharacterBody2D


const SPEED = 50
const JUMP_VELOCITY = -400.0
var right : bool = true
var stop : bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	velocity.x = 15

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 10000

	# Handle Jump.
	if not stop:
		if right:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
	else:
		velocity.x = 0 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.


	move_and_slide()


func _on_collision_query_body_exited(body):
	for child in body.get_children():
			if child is Plataforma:
				scale.x = -scale.x
				velocity.x = -velocity.x
				right = !right
