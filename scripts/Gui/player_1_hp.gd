extends CanvasLayer

@onready var text_label_p1 =  $Label
@onready var hearts_p1 = $hearts

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	text_label_p1.text = "P1 puntuacion: " + str(GameManager.player_1_score)
	hearts_p1.size.x = 32 * GameManager.player_1_lives
	
	pass
