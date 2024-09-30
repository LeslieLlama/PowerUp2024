extends Control

@onready var fadeout: ColorRect = $Fadeout
var fruitsCollected = 0


func _ready() -> void:
	Signals.FruitCollected.connect(update_fruits_count)
	fadeout.color = Color(0,0,0,1)
	var tween = create_tween()
	tween.tween_property(fadeout, "color", Color(0,0,0,0), 0.5)


func _process(_delta: float) -> void:
	pass
	
func update_fruits_count():
	fruitsCollected += 1
	$FruitCountNum.text = str(fruitsCollected, "/3")
