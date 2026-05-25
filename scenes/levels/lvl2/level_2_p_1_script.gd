extends Node2D

@onready var meta = $meta

var meta_can = 80


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	meta.text = str(GameManager.player_1_score/10) + " / " + str(meta_can)
	
	if (GameManager.player_1_score/10) >= meta_can:
		get_tree().change_scene_to_file("res://scenes/GUI/p_1_lvl_complete.tscn")
	
	pass
