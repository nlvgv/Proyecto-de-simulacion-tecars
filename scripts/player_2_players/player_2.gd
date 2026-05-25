extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 3.0

var inicial_x = position.x
var grind_size = 64
var pos_grind = 0
var max_grinds = 1

func _ready() -> void:
	sprite.animation = "car_blue"
	pass

func _physics_process(delta: float) -> void:
	print(GameManager.player_1_score)
	var direction := Input.get_axis("left_a", "rigth_d")
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
	
	if GameManager.player_2_coll and GameManager.player_2_lives >= 1:
		player_col()
	else:
		sprite.modulate.a = 1
	
	if GameManager.player_2_lives < 1:
		sprite.modulate.a = 0
	
	move_and_slide()

func player_col():
	for i in range(3):
		sprite.modulate.a = 0.4
		await get_tree().create_timer(0.1).timeout
		sprite.modulate.a = 1.0 
		await get_tree().create_timer(0.1).timeout
