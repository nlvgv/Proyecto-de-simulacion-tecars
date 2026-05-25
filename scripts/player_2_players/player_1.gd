extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 3.0

var inicial_x = position.x
var grind_size = 64
var pos_grind = 0
var max_grinds = 1

var points = 0

func _ready() -> void:
	GameManager.in_game = true
	GameManager.game_speed=0
	GameManager.player_1_score = 0
	GameManager.player_1_lives = 3
	GameManager.player_2_score = 0
	GameManager.player_2_lives = 3
	sprite.animation = "car_red"


func _physics_process(delta: float) -> void:
	print(GameManager.player_1_score)
	var direction := Input.get_axis("ui_left", "ui_right")
	var move_dest = inicial_x + (grind_size * pos_grind)
	if direction:
		if position.x == move_dest:
			print(direction)
			pos_grind = pos_grind + direction
			print("move")
			print(pos_grind)
	
	if pos_grind > max_grinds:
		pos_grind = max_grinds
	elif pos_grind < max_grinds*-1:
		pos_grind = max_grinds*-1
		
	position.x = move_toward(position.x, move_dest, SPEED)
	
	if GameManager.player_1_lives <= 0 and GameManager.player_2_lives <= 0:
		get_tree().change_scene_to_file("res://scenes/GUI/p_2_players_game_over.tscn")
	
	if GameManager.player_1_coll and GameManager.player_1_lives >= 1:
		player_col()
	else:
		sprite.modulate.a = 1
	
	if GameManager.player_1_lives < 1:
		sprite.modulate.a = 0
	
	move_and_slide()

func player_col():
	for i in range(3):
		sprite.modulate.a = 0.4
		await get_tree().create_timer(0.1).timeout
		sprite.modulate.a = 1.0 
		await get_tree().create_timer(0.1).timeout
