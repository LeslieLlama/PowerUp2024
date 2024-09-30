extends Area2D


@onready var respawn_position: Node2D = $RespawnPosition



func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		body._on_RoomDetector_area_entered(self)
		Signals.emit_signal("CheckpointReached", respawn_position.global_position)
