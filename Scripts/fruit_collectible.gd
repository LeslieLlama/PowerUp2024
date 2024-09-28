extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add self to list of collectables in level
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#bob up and down slightly
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		#delete self, add +1 to collected fruits 
		Signals.emit_signal("FruitCollected")
		queue_free()
		pass
