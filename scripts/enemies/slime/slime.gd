extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

func ready():
	if is_on_floor():
		%Timer.start()
func _on_timer_timeout():
	print("Time to attack!")
	velocity.y = JUMP_VELOCITY
	velocity.x = SPEED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#else


	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
#		velocity.x = direction * SPEED
	#else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	pass # Replace with function body.
