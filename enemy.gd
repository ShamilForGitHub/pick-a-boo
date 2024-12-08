extends CharacterBody2D

var hp=50
func damage(amount):
	hp-=amount
	if hp<=0:
		queue_free()

func _physics_process(delta):
	velocity.x = sin(Engine.get_frames_per_second()/30.0)*20
	move_and_slide()
