extends Node2D

@onready var next_skin = $CanvasLayer/nxt_skin_btn
@onready var back_skin = $CanvasLayer/bck_skin_btn

@onready var skin_show = $CanvasLayer/AnimatedSprite2D

@onready var lvl_1 = $CanvasLayer/nivel_1
@onready var lvl_2 = $CanvasLayer/nivel_2
@onready var lvl_3 = $CanvasLayer/nivel_3

var next_was_press = false
var back_was_press = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	match GameManager.player_1_skin:
		1:
			skin_show.animation = "car_black"
		2:
			skin_show.animation = "car_blue"
		3:
			skin_show.animation = "car_green"
		4:
			skin_show.animation = "car_red"
	
	if next_skin.button_pressed:
		next_was_press = true
	elif next_was_press: 
		GameManager.player_1_skin += 1
		next_was_press = false
		
	if back_skin.is_pressed():
		back_was_press = true
	
	elif back_was_press: 
		GameManager.player_1_skin -= 1
		back_was_press = false
	
	if GameManager.player_1_skin > 4:
		GameManager.player_1_skin = 1
	elif GameManager.player_1_skin < 1:
		GameManager.player_1_skin = 4
		
	if lvl_1.button_pressed:
		get_tree().change_scene_to_file("res://scenes/levels/lvl1/Level_1_p1.tscn")
	if lvl_2.button_pressed:
		get_tree().change_scene_to_file("res://scenes/levels/lvl2/Level_2_p1.tscn")	
	if lvl_3.button_pressed:
		get_tree().change_scene_to_file("res://scenes/levels/lvl3/Level_3_p1.tscn")	
	
	pass
