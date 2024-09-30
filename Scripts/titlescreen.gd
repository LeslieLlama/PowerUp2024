extends Node2D

@onready var fadeout: ColorRect = $Fadeout
@export var target_level : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fadeout.color = Color(0,0,0,1)
	var tween = create_tween()
	tween.tween_property(fadeout, "color", Color(0,0,0,0), 0.5)
	#tween.tween_callback(_set_slide_to_false)
	$FruitCount.text = str(Signals.fruitcount,"/12")

func _load_new_scene():
	get_tree().change_scene_to_packed(target_level)


func _on_play_button_button_down() -> void:
	var tween = create_tween()
	tween.tween_property(fadeout, "color", Color(0,0,0,1), 0.8)
	tween.tween_callback(_load_new_scene)
