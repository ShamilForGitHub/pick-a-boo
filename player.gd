extends CharacterBody2D

const BASE_SPEED = 250.0
const BASE_JUMP = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_attack = false

var speed = BASE_SPEED
var jump = BASE_JUMP

func _ready():
	update_stats()

func update_stats():
	var g = Global
	speed = BASE_SPEED + (g.upgrades.get("speed", 1) - 1) * 20  # Изменение
	jump = BASE_JUMP - (g.upgrades.get("jump", 1) - 1) * 20  # Изменение
	can_attack = g.upgrades.get("attack", 0) > 0  # Изменение
	var cam = $Camera2D
	var zoom_base = 3.0
	var zoom_mod = float(6 - g.upgrades.get("vision", 1)) / 1.0  # Изменение
	cam.zoom = Vector2(zoom_base + zoom_mod, zoom_base + zoom_mod)

func update_camera_vision():
	update_stats()

func unlock_charisma_features():
	pass

func lock_charisma_features():
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump
		$JumpSfx.play()

	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * speed
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = (direction == -1)
	else:
		velocity.x = 0  # Немедленно обнуляем скорость
		$AnimatedSprite2D.play("idle")

	if not is_on_floor():
		$AnimatedSprite2D.play("jump")

	if can_attack and Input.is_action_just_pressed("ui_attack"):
		perform_attack()

	move_and_slide()


func perform_attack():
	var g = Global
	var range = g.upgrades.get("attack_range", 1) * 30  # Изменение
	var space = get_world_2d().direct_space_state
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(range, 10)

	var attack_position = position + Vector2(-range if $AnimatedSprite2D.flip_h else range, 0)

	var params = PhysicsShapeQueryParameters2D.new()
	params.shape = shape
	params.transform = Transform2D(0, attack_position)
	params.collide_with_bodies = true
	params.collide_with_areas = false
	params.collision_mask = 0b000001  # Изменение

	var res = space.intersect_shape(params, 100)
	for r in res:
		var b = r.collider
		if b.has_method("damage"):
			b.damage(g.upgrades.get("attack", 0) * 10)
