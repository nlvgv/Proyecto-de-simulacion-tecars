extends Area2D

@onready var animated = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

var give_point = true
var score_points = 10

const SPEED = 112.0
var inicial_pos

var is_p2

var pos_list = []
var can_colide = true

func _ready() -> void:
	randomize() 
	body_entered.connect(_on_body_entered)
	
	inicial_pos = get_parent().get_meta("inicial_pos")
	pos_list = [ inicial_pos - 64, inicial_pos, inicial_pos + 64 ]
	
	rand_position()
	
	is_p2 = get_parent().get_meta("p2")
	
	var rand_pos = randi() % pos_list.size()
	global_position.x = pos_list[rand_pos]
	animated.frame = randi() % 4


func _process(delta: float) -> void:
	global_position.y += (SPEED + GameManager.game_speed) * delta
	
	if global_position.y > 304 and give_point:
		if is_p2 and GameManager.player_2_lives >= 1:
			GameManager.player_2_score += score_points
		elif GameManager.player_1_lives >= 1:
			GameManager.player_1_score += score_points
		give_point = false
	
	if global_position.y >= 384:
		rand_position()
		global_position.y -= 416
		animated.frame = randi() % 4
		give_point = true
		can_colide = true

func rand_position() -> void:
	var rand_pos = randi() % pos_list.size()
	global_position.x = pos_list[rand_pos]

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("player_1"):
		if can_colide and GameManager.player_1_coll == false and GameManager.player_1_lives > 0:
			GameManager.player_1_coll = true
			GameManager.player_1_lives -= 1
			can_colide = false
	elif body.is_in_group("player_2"):
		if can_colide and GameManager.player_2_coll == false and GameManager.player_2_lives > 0:
			GameManager.player_2_coll = true
			GameManager.player_2_lives -= 1
			can_colide = false
