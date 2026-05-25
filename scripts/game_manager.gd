extends Node

var two_player_game = false
var in_game = false

var player_1_score = 0
var player_2_score = 0

var player_1_lives = 3
var player_2_lives = 3

var player_1_skin = 1
var player_2_skin = 1

var game_speed = 1

var player_1_coll = false;
var player_2_coll = false;

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var total_score = player_1_score + player_2_score
	if in_game: 
		if two_player_game:
			game_speed = total_score/8
		else:
			game_speed = player_1_score / 4
			
	if player_1_coll:
		await get_tree().create_timer(0.5).timeout
		player_1_coll = false
	if player_2_coll:
		await get_tree().create_timer(0.5).timeout
		player_2_coll = false
	
	pass
