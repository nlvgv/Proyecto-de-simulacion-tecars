extends Node2D

var speed = 112

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if position.y >= 384:
		position.y -= 768
	
	position.y += (speed + GameManager.game_speed) * delta
	

	
	pass
