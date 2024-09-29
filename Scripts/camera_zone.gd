extends Area2D





func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		body._on_RoomDetector_area_entered(self)
