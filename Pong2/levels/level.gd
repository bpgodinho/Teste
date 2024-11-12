extends Node

var player_score := 0
var opponent_score := 0

@onready var player_score_label: Label = $HBoxContainer/PlayerScore
@onready var opponent_score_label: Label = $HBoxContainer/OpponentScore
@onready var ball: Ball = $Ball
@onready var countdown_timer: Timer = $CountdownTimer
@onready var countdown_label: Label = $CountdownLabel
@onready var player_1_name: Label = $Player1Name
@onready var player_2_name: Label = $Player2Name
@onready var match_timer: Timer = $MatchTimer
@onready var player_paddle: CharacterBody2D = $PlayerPaddle
@onready var opponent: CharacterBody2D = $Opponent
@onready var time_left: Label = $VBoxContainer/time_left
@onready var first_to: Label = $VBoxContainer/FirstTo
@onready var victory_screen: TextureRect = $victory_screen
@onready var winner: Label = $victory_screen/VBoxContainer/winner

var running : bool = false

func _ready() -> void:
	#Set the in-game match timer's text or hide it depending on the time limit settings
	if GameManager.time_limit > 0:
		match_timer.wait_time = GameManager.time_limit * 60
		print(match_timer.wait_time)
		time_left.text = str(ceil(match_timer.wait_time / 60)) + " : " + str(floor(match_timer.wait_time - (floor(match_timer.wait_time / 60)*60))) 
	else:
		time_left.hide()
	if GameManager.point_limit > 0:
		first_to.text = "FIRST TO " + str(GameManager.point_limit)
	else:
		first_to.hide()
	#Set the player names and paddle colors
	player_2_name.text = GameManager.player2_name
	player_1_name.text = GameManager.player1_name


func _process(_delta: float) -> void:
	#Count down the time on the in-game timer
	if running:
		time_left.text = str(floor(match_timer.time_left / 60)) + " : " + str(floor(match_timer.time_left - (floor(match_timer.time_left / 60)*60)))
	countdown_label.text = str(ceil(countdown_timer.time_left))
	#Check if anyone has won
	if player_score == GameManager.point_limit || opponent_score == GameManager.point_limit:
		end_game()

#Reset the ball position and add a point to the scoreboard
func _on_wall_left_body_entered(body: Node2D) -> void:
	ball.reset_ball()
	opponent_score += 1
	opponent_score_label.text = str(opponent_score)
	match_timer.paused = true
	countdown_timer.start()
	countdown_label.show()
	AudioManager.audio_play("res://assets/Audio/ping_pong_8bit_beeep.ogg")

#Reset the ball position and add a point to the scoreboard
func _on_wall_right_body_entered(body: Node2D) -> void:
	ball.reset_ball()
	player_score += 1
	player_score_label.text = str(player_score)
	match_timer.paused = true
	countdown_timer.start()
	countdown_label.show()
	AudioManager.audio_play("res://assets/Audio/ping_pong_8bit_beeep.ogg")

#Make the ball move after a short time
func _on_countdown_timer_timeout() -> void:
	ball.start_moving()
	countdown_label.hide()
	if match_timer.paused:
		match_timer.paused = false
	elif GameManager.time_limit > 0:
		match_timer.start()
	running = true

#Evaluate the winner and end the game when the match timer hits zero
func _on_match_timer_timeout() -> void:
	end_game()

#Evaluate the winner and show a winner screen
func end_game() -> void:
	get_tree().paused = true
	victory_screen.show()
	match_timer.paused = true
	AudioManager.audio_play("res://assets/Audio/WinSound.mp3")
	if player_score == opponent_score:
		winner.text = "DRAW"
	else:
		winner.text = (GameManager.player1_name if player_score > opponent_score else GameManager.player2_name) + " WINS"
