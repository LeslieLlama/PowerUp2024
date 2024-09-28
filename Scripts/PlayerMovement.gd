extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = Vector2(0,980)
var slowfallGravity = Vector2(0,40)
var direction
var stamina = 0
var max_stamina = 60
var stamina_refresh_rate = 60
enum States{IDLE, RUNNING, FALLING, GLIDING, CLIMBING}
var state: States = States.IDLE

func _ready() -> void:
	Signals.PlayerDamage.connect(_take_damage)

func _process(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	
	#state machine
	if direction:
		state = States.RUNNING
	else:
		state = States.IDLE
	if not is_on_floor() and not is_on_wall():
		if Input.is_action_pressed("action_1"):
			state = States.GLIDING
		else: state = States.FALLING
	if is_on_wall():
		if Input.is_action_pressed("action_1") && stamina > 0:
			state = States.CLIMBING
			
	
	
	$Label.text = str("state : ", state)
	var a = "%.0f" % stamina
	$StaminaLabel.text = str("Stamina : ", a)

func _physics_process(delta: float) -> void:
	
	if state == States.GLIDING:
		velocity += slowfallGravity * delta
		$WingsSprite.visible = true
	if state == States.FALLING:
		pass
	if state == States.CLIMBING:
		velocity.y = JUMP_VELOCITY/2
		if stamina > 0:
			stamina -= 20 * delta
	if state == States.RUNNING:
		velocity.x = direction * SPEED
		if stamina < max_stamina:
			stamina += stamina_refresh_rate * delta
	if state == States.IDLE:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if stamina < max_stamina:
			stamina += stamina_refresh_rate * delta
	if state in [States.IDLE, States.RUNNING, States.FALLING]:
		velocity += gravity * delta
		$WingsSprite.visible = false
		

	# Handle jump.
	#if Input.is_action_just_pressed("action_1") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _take_damage():
	print("owch!")
