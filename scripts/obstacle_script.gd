extends Area2D

@onready var animated = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var respawn_timer = $RespawnTimer

var give_point = true
var score_points = 10

const SPEED = 112.0

var inicial_pos
var is_p2

# Lista de carriles
var pos_list = []

var can_colide = true
var waiting_respawn = false


# DISTRIBUCIÓN EXPONENCIAL
#tiempo entre carros
var lambda_time = 2.5

# Controla distribución de carriles
var lambda_lane = 0.4


func _ready() -> void:
	randomize()

	body_entered.connect(_on_body_entered)

	inicial_pos = get_parent().get_meta("inicial_pos")

	# 3 carriles
	pos_list = [
		inicial_pos - 64,
		inicial_pos,
		inicial_pos + 64
	]

	rand_position()

	is_p2 = get_parent().get_meta("p2")

	animated.frame = randi() % 4

	respawn_timer.timeout.connect(_on_respawn_timer_timeout)


func _process(delta: float) -> void:

	# Mientras espera respawn no se mueve
	if waiting_respawn:
		return

	global_position.y += (SPEED + GameManager.game_speed) * delta

	# Dar puntos
	if global_position.y > 304 and give_point:

		if is_p2 and GameManager.player_2_lives >= 1:
			GameManager.player_2_score += score_points

		elif GameManager.player_1_lives >= 1:
			GameManager.player_1_score += score_points

		give_point = false

	# Cuando sale de pantalla
	if global_position.y >= 384:
		start_exponential_respawn()


# RESPAWN 

func start_exponential_respawn():

	waiting_respawn = true

	visible = false
	collision.disabled = true

	var tiempo_espera = generar_tiempo_exponencial()

	respawn_timer.wait_time = tiempo_espera
	respawn_timer.start()


func generar_tiempo_exponencial() -> float:

	# Fórmula exponencial
	var u = randf()

	var tiempo = -log(1 - u) / lambda_time

	# Limitar tiempos extremos
	tiempo = clamp(tiempo, 0.3, 3.0)

	return tiempo



#reaparicion
func _on_respawn_timer_timeout():

	waiting_respawn = false

	visible = true
	collision.disabled = false

	# Elegir carril usando distribución exponencial
	rand_position()

	# Subir arriba de la pantalla
	global_position.y = -64

	animated.frame = randi() % 4

	give_point = true
	can_colide = true



# DISTRIBUCIÓN EXPONENCIAL DE CARRILES

func rand_position() -> void:

	# Número aleatorio uniforme
	var u = randf()

	# Distribución exponencial
	var valor = -log(1 - u) / lambda_lane

	# Convertir a índice de carril
	var carril = int(valor)

	# Limitar entre 0 y 2
	carril = clamp(carril, 0, pos_list.size() - 1)

	global_position.x = pos_list[carril]


# COLISIONES

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("player") or body.is_in_group("player_1"):

		if can_colide and GameManager.player_1_coll == false and GameManager.player_1_lives > 0:

			GameManager.player_1_coll = true
			GameManager.player_1_lives -= 1

			can_colide = false

			start_exponential_respawn()

	elif body.is_in_group("player_2"):

		if can_colide and GameManager.player_2_coll == false and GameManager.player_2_lives > 0:

			GameManager.player_2_coll = true
			GameManager.player_2_lives -= 1

			can_colide = false

			start_exponential_respawn()
