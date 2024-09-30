extends Node2D


signal health_depleted
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.PlayerDamage.connect(respawn)
	Signals.CheckpointReached.connect(newCheckpoint)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func respawn():
	$PlayerCharacter.position = $CharacterRespawn.position
	
func newCheckpoint(newPosition):
	$CharacterRespawn.position = newPosition
