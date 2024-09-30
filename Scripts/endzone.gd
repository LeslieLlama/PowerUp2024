extends Area2D

@export var target_level : PackedScene
# Called when the node enters the scene tree for the first time.


func _load_new_scene():
	get_tree().change_scene_to_packed(target_level)


func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		call_deferred("_load_new_scene")
