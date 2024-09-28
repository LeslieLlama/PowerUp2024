extends Control

var fruitsCollected = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.FruitCollected.connect(update_fruits_count)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_fruits_count():
	fruitsCollected += 1
	$"../FruitCountNum".text = str(fruitsCollected, "/3")
