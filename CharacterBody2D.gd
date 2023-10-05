extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const initialPos = Vector2(519,554)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var oldDirection : float = 1
@onready var coyote_timer = $CoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += gravity * delta
		else:
			velocity.y += gravity * 1.75 * delta
			velocity.y = clamp(velocity.y, 0, 750)
		
	# Handle Jump.
	if Input.is_action_just_pressed("ui_select"):
		jump_buffer_timer.start()
	
	if not jump_buffer_timer.is_stopped() and (is_on_floor() or not coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer.stop()
	if Input.is_action_just_released("ui_select") and not is_on_floor() and velocity.y < 0:
		velocity.y /= velocity.y 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if (direction != oldDirection and direction != 0):
		scale.x = -scale.x
		oldDirection = direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
	if position.y >= 650:
		position = initialPos
	
