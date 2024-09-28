extends Area2D

@export var boost_velocity = -900

func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		body.velocity.y = boost_velocity
