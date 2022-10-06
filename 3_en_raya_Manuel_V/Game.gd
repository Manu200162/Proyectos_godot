# Manuel Valenzuela
# 05-10-2022
# Juego de 3 en raya


extends Control

# Variables iniciales para configurar el juego
var board : Array

var player : String

var is_winner: bool = false

var is_over: bool = false

var is_draw: bool = false

# Cargar las imagenes del juego
var fondo = preload("res://assets/background.png")

var player_x = preload("res://assets/x-player.png")

var player_o = preload("res://assets/o-player.png")

# Constructor del tablero de juego
func init_game() -> void:
	board = [
		"0", "0", "0",
		"0", "0", "0",
		"0", "0", "0"
	]
	$Tablero/Fila0/Casilla0.texture_normal = fondo
	$Tablero/Fila0/Casilla1.texture_normal = fondo
	$Tablero/Fila0/Casilla2.texture_normal = fondo
	$Tablero/Fila1/Casilla3.texture_normal = fondo
	$Tablero/Fila1/Casilla4.texture_normal = fondo
	$Tablero/Fila1/Casilla5.texture_normal = fondo
	$Tablero/Fila2/Casilla6.texture_normal = fondo
	$Tablero/Fila2/Casilla7.texture_normal = fondo
	$Tablero/Fila2/Casilla8.texture_normal = fondo
	is_over = false
	is_winner = false
	is_draw = false	

# El jugador X empieza la partida
func init_player() -> void:
	player = "x"

# Inicio del script
func _ready() -> void:
	$GameOverMessage.hide()
	init_game()
	init_player()

# Cada vez que se juegue se cambia de X a O , tambien de O a X
func update_player() -> void:
	if player == "x":
		player = "o"
	else:
		player = "x"

# Tres metodos para verificar si existe 3 en raya en una fila, en una columna o una diagonal
func is_a_row() -> bool:
	var offset = 0
	for row in range(3):
		for index in range(0 + offset, 3 + offset):
			if board[index] == player:
				is_winner = true
			else:
				is_winner = false
				break
		if is_winner:
			return true
		offset += 3
	return false

func is_a_col() -> bool:
	var offset = 0
	for col in range(3):
		for index in range(0 + offset, 7 + offset, 3):
			if board[index] == player:
				is_winner = true
			else:
				is_winner = false
				break
		if is_winner:
			return true
		offset += 1
	return false
	

func is_a_diag() -> bool:
	for i in range(0, 9, 4):
		if board[i] == player:
			is_winner = true
		else:
			is_winner = false
			break
	if is_winner:
		return true
	for i in range(2, 7, 2):
		if board[i] == player:
			is_winner = true
		else:
			is_winner = false
			break
	if is_winner:
		return true
	return false

# Comprobar si el tablero ya no tiene casillas
func is_board_full() -> bool:
	if board.has("0"):
		return false
	return true

# Verificar si el juego ya termino o por que alguien gano o por que se lleno el tablero
func check_gameover() -> void:
	if is_a_row() || is_a_col() || is_a_diag():
		is_over = true
		add_gameover_message()
	elif is_board_full():
		is_over = true
		is_draw = true
		add_gameover_message()

# 	Mandar el mensaje de juego terminado
func add_gameover_message() -> void:
	if is_draw:
		$GameOverMessage/Container/Label.text = "Es un empate!!!"
	else:
		$GameOverMessage/Container/Label.text = "El jugador " + player + " gano!"
	$GameOverMessage.show()

# Dibujar la siguiente movida
func draw_move(index: int) -> void:
	board[index] = player
	check_gameover()

# Verificar si la casilla no se pinto antes
func is_square_free(index: int) -> bool:
	if board[index] == "0":
		return true
	return false

# Dibujar X o O dependiendo quien esta jugando
func update_board(row: int, index: int) -> void:
	var path = "Tablero/Fila" + String(row) + "/Casilla" + String(index)
	if player == "x":
		get_node(path).texture_normal = player_x
	elif player == "o":
		get_node(path).texture_normal = player_o
	update_player()
	
# SIGNALS
# Cada casilla es un boton, que cuando se presiona manda un signal
func _on_Casilla0_button_up() -> void:
	if is_square_free(0) && !is_over:
		draw_move(0)
		update_board(0, 0)


func _on_Casilla1_button_up() -> void:
	if is_square_free(1) && !is_over:
		draw_move(1)
		update_board(0, 1)


func _on_Casilla2_button_up() -> void:
	if is_square_free(2) && !is_over:
		draw_move(2)
		update_board(0, 2)


func _on_Casilla3_button_up() -> void:
	if is_square_free(3) && !is_over:
		draw_move(3)
		update_board(1, 3)

func _on_Casilla4_button_up() -> void:
	if is_square_free(4) && !is_over:
		draw_move(4)
		update_board(1, 4)


func _on_Casilla5_button_up() -> void:
	if is_square_free(5) && !is_over:
		draw_move(5)
		update_board(1, 5)


func _on_Casilla6_button_up() -> void:
	if is_square_free(6) && !is_over:
		draw_move(6)
		update_board(2, 6)


func _on_Casilla7_button_up() -> void:
	if is_square_free(7) && !is_over:
		draw_move(7)
		update_board(2, 7)


func _on_Casilla8_button_up() -> void:
	if is_square_free(8) && !is_over:
		draw_move(8)
		update_board(2, 8)


func _on_RestartButton_button_up() -> void:
	$GameOverMessage.hide()
	init_game()
	init_player()
