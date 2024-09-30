extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = Vector2(0,980)
var slowfallGravity = Vector2(0,40)
var direction
var stamina = 0
var max_stamina = 300
var stamina_refresh_rate = 60
enum States{IDLE, RUNNING, FALLING, GLIDING, CLIMBING, CEILING_CLIMB}
var state: States = States.IDLE


func _ready() -> void:
	Signals.PlayerDamage.connect(_take_damage)

func _process(_delta: float) -> void:
	direction = Input.get_axis("left", "right")
	#state machine
	if direction:
		$RayCast2D.target_position = Vector2(15*direction,0) 
		set_state(States.RUNNING)
		if direction < 0: $AnimatedSprite2D.flip_h = true
		if direction > 0: $AnimatedSprite2D.flip_h = false
			
	else:
		set_state(States.IDLE)
	if not is_on_floor() and not is_on_wall() and velocity.y > 0:
		if Input.is_action_pressed("action_1"):
			set_state(States.GLIDING)
		else: set_state(States.FALLING)
	if $RayCast2D.is_colliding():
		#direction = 0
		#velocity.x = 0
		if Input.is_action_pressed("action_1"):
			set_state(States.CLIMBING)
	if $RayCast2D2.is_colliding():
		if Input.is_action_pressed("action_1"):
			set_state(States.CEILING_CLIMB)
			
	#var onSpikes = World.get_custom_data_at(position, "on_spikes")
	
	$DirectionLabel.text = str("direction : ", direction)
	$Label.text = str("state : ", state)
	var a = "%.0f" % stamina
	$StaminaLabel.text = str("Stamina : ", a)

func set_state(new_state: States) -> void:
	var previous_state := state
	state = new_state
	
	if previous_state == States.CLIMBING:
		velocity.y = JUMP_VELOCITY
		

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		if stamina < max_stamina:
			stamina += stamina_refresh_rate * delta
	
	if state == States.GLIDING:
		velocity += slowfallGravity * delta
		#$WingsSprite.visible = true
		$AnimatedSprite2D.play("Flying")
	if state == States.FALLING:
		$AnimatedSprite2D.play("Falling")
	if state == States.CLIMBING:
		velocity.y = JUMP_VELOCITY/2
		if $AnimatedSprite2D.flip_h == true:
			$AnimatedSprite2D.rotation = 90
		if $AnimatedSprite2D.flip_h == false:
			$AnimatedSprite2D.rotation = -90
		$AnimatedSprite2D.play("Running")
		if stamina > 0:
			stamina -= 20 * delta
	if state == States.CEILING_CLIMB:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.rotation = -180
		$AnimatedSprite2D.play("Running")
		if direction == 0:
			$AnimatedSprite2D.play("Idle")
	if state == States.RUNNING:
		$AnimatedSprite2D.play("Running")
	if state == States.IDLE:
		$AnimatedSprite2D.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if state in [States.IDLE, States.RUNNING, States.FALLING]:
		velocity += gravity * delta
		#$WingsSprite.visible = false
		
	if state in [States.RUNNING, States.GLIDING, States.FALLING]:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	if state in [States.RUNNING,States.IDLE, States.GLIDING, States.FALLING]:
		$AnimatedSprite2D.rotation = 0
		
	# Handle jump.
	#if Input.is_action_just_pressed("action_1") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	#var direction := Input.get_axis("left", "right")
	
		
	move_and_slide()

func _on_RoomDetector_area_entered(area: Area2D) -> void:
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2
	
	#for if room is smaller than viewport size
	var view_size = get_viewport_rect().size
	if size.y < view_size.y:
		size.y = view_size.y
		
	if size.x < view_size.x:
		size.x = view_size.x
	
	var cam = $Camera2D
	cam.limit_top = collision_shape.global_position.y - size.y/2
	cam.limit_left = collision_shape.global_position.x - size.x/2
	
	cam.limit_bottom = cam.limit_top + size.y
	cam.limit_right = cam.limit_left + size.x
	
	
func _take_damage():
	print("owch!")
