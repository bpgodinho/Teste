extends Control

@onready var cpu: Sprite2D = $Cpu
@onready var player_1_name_field: LineEdit = %player1_name_field
@onready var player_2_name_field: LineEdit = %player2_name_field
@onready var difficulty_button: Button = %difficulty_button
@onready var player_1_preview: ColorRect = %player1_preview
@onready var player_2_preview: ColorRect = %player2_preview
@onready var current_selection_points: TextureRect = $HBoxContainer/VBoxContainer3/VBoxContainer4/HBoxContainer/current_selection_points
@onready var current_selection_time: TextureRect = $HBoxContainer/VBoxContainer3/VBoxContainer4/HBoxContainer/current_selection_time
@onready var continue_control: Control = $HBoxContainer/VBoxContainer3/menu/continue_control
@onready var difficulty_control: Control = $HBoxContainer/VBoxContainer3/menu/difficulty_control
@onready var main_menu_control: Control = $HBoxContainer/VBoxContainer3/menu/main_menu_control
@onready var match_settings_control: Control = $HBoxContainer/VBoxContainer3/VBoxContainer4/match_settings_control


var x = 100
var y = 20.5
var difficulties = ["EASY", "MEDIUM", "HARD"]

func _ready() -> void:
	print(!GameManager.pvp)
	#Set the difficulty text to the current difficulty
	difficulty_button.text = difficulties[GameManager.dificulty]
	#Set the icon for the poit and time limit to the current respective values
	current_selection_points.texture = GameManager.points_icon
	current_selection_time.texture = GameManager.time_icon
	#Set the name and color of player 1 to the current respective values
	player_1_name_field.text = GameManager.player1_name
	player_1_preview.color = GameManager.player_1_color
	#In case of singleplayer mode set the player 2 name as CPU, make it uneditable, show the difficulty button and the CPU graphic
	if !GameManager.pvp:
		player_2_name_field.text = "CPU"
		player_2_name_field.editable = false
		difficulty_control.show()
		cpu.show()
	else:
		#In case  of multiplayer set the name and color of player 2 to the respective values
		player_2_name_field.text = GameManager.player2_name
		player_2_preview.color = GameManager.player_2_color


func _on_continue_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_high.mp3")
	#Await until animation is done playing before executing logic and changing scenes
	await GlobalAnimationPlayer.play_animation(continue_control)
	#Check if the players have introduced a name and if so proceed. If not change the placeholder text to warn them
	if player_1_name_field.text == "":
		player_1_name_field.placeholder_text = "Please choose a name"
		if GameManager.pvp && player_2_name_field.text == "":
			player_2_name_field.placeholder_text = "Please choose a name"
	else:
		if GameManager.pvp && player_2_name_field.text == "":
			player_2_name_field.placeholder_text = "Please choose a name"
		else:
			#If both players have names set, saev the customization options and proceed
			GameManager.player_1_color = player_1_preview.color
			GameManager.player_2_color = player_2_preview.color
			GameManager.player1_name = player_1_name_field.text
			GameManager.player2_name = player_2_name_field.text
			AudioManager.change_music("res://assets/Audio/GD_practice.mp3")
			get_tree().change_scene_to_file("res://levels/level.tscn")


func _on_main_menu_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_low.mp3")
	#Await until animation is done playing before executing logic and changing scenes
	await GlobalAnimationPlayer.play_animation(main_menu_control)
	#Reset customization preferences
	GameManager.reset()
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func _on_difficulty_button_pressed() -> void:
	#No need to await since we dont change scenes
	GlobalAnimationPlayer.play_animation(difficulty_control)
	AudioManager.audio_play("res://assets/Audio/button_high.mp3")
	#Wrap through the difficulty settings
	GameManager.dificulty = wrapi(GameManager.dificulty + 1, 0, difficulties.size())
	difficulty_button.text = difficulties[GameManager.dificulty]


func _on_match_settings_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_high.mp3")
	#Await for animation to end before changing scene
	await GlobalAnimationPlayer.play_animation(match_settings_control)
	GameManager.player_1_color = player_1_preview.color
	GameManager.player_2_color = player_2_preview.color
	GameManager.player1_name = player_1_name_field.text
	GameManager.player2_name = player_2_name_field.text
	get_tree().change_scene_to_file("res://match_options/match_settings.tscn")
