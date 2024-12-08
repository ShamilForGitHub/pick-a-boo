extends Area2D

signal talk(text)

func _ready():
	if has_node("CollisionShape2D"):
		$CollisionShape2D.disabled=false

func _on_body_entered(body):
	if body.name=="Player":
		emit_signal("talk","Hello hero! I can share secrets. With Charisma, more secrets unlock.")
