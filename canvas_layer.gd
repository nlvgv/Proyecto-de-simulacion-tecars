extends CanvasLayer

@onready var text_label =  $Label
@onready var hearts = $hearts

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	text_label.text = "P1 puntuacion: " + str(GameManager.player_1_score)
	hearts.size.x = 32 * GameManager.player_1_lives
	
	pass
