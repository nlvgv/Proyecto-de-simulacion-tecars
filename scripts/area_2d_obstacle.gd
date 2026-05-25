extends Area2D

@onready var animated = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

var give_point = true
var score_points = 10

const SPEED = 112.0
var pos_list = [256, 320, 384]
var can_colide = true

func _ready() -> void:
	randomize() 
	body_entered.connect(_on_body_entered)
	
	var rand_pos = randi() % pos_list.size()
	global_position.x = pos_list[rand_pos]
	animated.frame = randi() % 4


func _process(delta: float) -> void:
	global_position.y += (SPEED + GameManager.game_speed) * delta
	
	if global_position.y > 304 and give_point:
		GameManager.player_1_score += score_points
		give_point = false
	
	if global_position.y >= 384:
		var rand_pos = randi() % pos_list.size()
		global_position.y -= 416
		global_position.x = pos_list[rand_pos]
		animated.frame = randi() % 4
		give_point = true
		can_colide = true


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if can_colide and GameManager.player_1_coll == false:
			GameManager.player_1_coll = true
			GameManager.player_1_lives -= 1
			can_colide = false
