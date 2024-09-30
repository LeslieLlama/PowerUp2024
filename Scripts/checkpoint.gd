extends Area2D


	
func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Signals.emit_signal("CheckpointReached", global_position)
