extends CollisionShape2D
@onready var attack_timer = $AttackTimer
func _ready():
	
	get_node("spriteAtaque").visible = false
	disabled = true
func _input(delta):
	if Input.is_key_pressed(KEY_A) and not get_node("spriteAtaque").visible:
			get_node("spriteAtaque").visible = true
			disabled = false
			attack_timer.start()
func _process(delta):
	if get_node("spriteAtaque").visible and attack_timer.is_stopped():
			get_node("spriteAtaque").visible = false
			disabled = true
#	if Input.is_key_pressed(KEY_ENTER):
#		if get_node("spriteAtaque").visible:
#			get_node("spriteAtaque").visible = false
#		else:
#			get_node("spriteAtaque").visible = true
