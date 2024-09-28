extends Area2D


@export var boost_velocity = -150
var floating_objects: Array[Node]

func _process(delta: float) -> void:
	for obj in floating_objects:
		obj.velocity.y = boost_velocity

func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		floating_objects.append(body)
		

func _on_body_exited(body: Node2D) -> void:
	floating_objects.remove_at(floating_objects.find(body))
