extends CanvasLayer

@onready var points_p1 = $points_p1_text
@onready var points_p2 = $points_p2_text

@onready var menu_btn = $menu_btn
@onready var go_text = $game_over_text


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points_p1.text = "Puntuacion del Jugador 1: " + str(GameManager.player_1_score)
	points_p2.text = "Puntuacion del Jugador 2: " + str(GameManager.player_2_score)
	
	if GameManager.player_1_score > GameManager.player_2_score:
		go_text.text = "Player 1 wins"
	else:
		go_text.text = "Player 2 wins"
	
	if menu_btn.button_pressed:
		get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")
