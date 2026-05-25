extends CanvasLayer

@onready var points_p1 = $points_p1_text

@onready var menu_btn = $menu_btn
@onready var selec_btn = $selec_btn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points_p1.text = "Puntuacion del Jugador: " + str(GameManager.player_1_score)
	
	if menu_btn.button_pressed:
		get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")
	if selec_btn.button_pressed:
		get_tree().change_scene_to_file("res://scenes/GUI/selec_levels.tscn")
