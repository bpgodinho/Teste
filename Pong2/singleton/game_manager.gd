extends Node

#PLAYER VARS
var player1_name: String
var player2_name: String
var player_1_color: Color = Color(1,1,1,1)
var player_2_color: Color = Color(1,1,1,1)

#GAME VARS
var point_limit : int = 5
var time_limit : int = -1
var pvp : int = 0
var dificulty := 0

#MENU VARS
var points_icon : Texture2D = preload("res://assets/UI/UI-Dark/5pointsButtonNew.png")
var time_icon : Texture2D = preload("res://assets/UI/UI-Dark/InfiniteTimeButtonNEW.png")
var realism : bool = false

#Reset all variables
func reset() -> void:
	player_1_color = Color(1,1,1,1)
	player_1_color = Color(1,1,1,1)
	player1_name = ""
	player2_name = ""
	time_limit = -1
	point_limit = 5
	dificulty = 0
	points_icon = preload("res://assets/UI/UI-Dark/5pointsButtonNew.png")
	time_icon = preload("res://assets/UI/UI-Dark/InfiniteTimeButtonNEW.png")
