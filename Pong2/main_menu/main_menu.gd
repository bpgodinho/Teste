extends Control

@onready var single_player_control: Control = $central_container/buttons/single_player_control
@onready var single_player_button: Button = $central_container/buttons/single_player_control/single_player_button
@onready var multiplayer_control: Control = $central_container/buttons/multiplayer_control
@onready var multiplayer_button: Button = $central_container/buttons/multiplayer_control/multiplayer_button
@onready var quit_control: Control = $central_container/buttons/quit_control
@onready var quit_button: Button = $central_container/buttons/quit_control/quit_button


#Play audio and animations
func _on_single_player_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_high.mp3")
	#Await until animation is done playing before executing logic and changing scenes
	await GlobalAnimationPlayer.play_animation(single_player_control)
	GameManager.pvp = 0
	get_tree().change_scene_to_file("res://customization/customization.tscn")

#Play audio and animations
func _on_multiplayer_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_high.mp3")
	#Await until animation is done playing before executing logic and changing scenes
	await GlobalAnimationPlayer.play_animation(multiplayer_control)
	GameManager.pvp = 1
	GameManager.dificulty = 2
	get_tree().change_scene_to_file("res://customization/customization.tscn")

#Play audio and animtaions
func _on_quit_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_low.mp3")
	#Await until animation is done playing before closing the game
	await GlobalAnimationPlayer.play_animation(quit_control)
	get_tree().quit()
