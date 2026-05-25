extends Node2D

@onready var play = $CanvasLayer/play_button
@onready var play_2 = $"CanvasLayer/2_player_play"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if play.button_pressed:
		get_tree().change_scene_to_file("res://scenes/GUI/selec_levels.tscn")
		
	if play.button_pressed:
		get_tree().change_scene_to_file("")
	
	pass
