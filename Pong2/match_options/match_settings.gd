extends Control

@onready var current_points_selection_icon: TextureRect = $settings/middle_panel/current_selection/current_points_selection/current_points_selection_icon
@onready var current_points_selection_label: Label = %current_points_selection_label
@onready var current_time_selection_icon: TextureRect = $settings/middle_panel/current_selection/current_time_selection/current_time_selection_icon
@onready var current_time_selection_label: Label = %current_time_selection_label
@onready var go_back_button_control: Control = $settings/middle_panel/go_back_button_control



var time_limit = GameManager.time_limit
var point_limit = GameManager.point_limit


func _ready() -> void:
	#Set the point and time icons and text to their respective values
	current_points_selection_icon.texture = GameManager.points_icon
	current_time_selection_icon.texture = GameManager.time_icon
	current_time_selection_label.text = "NO TIME LIMIT" if time_limit < 0 else str(time_limit) + " MINUTES"
	current_points_selection_label.text = "NO POINT LIMIT" if point_limit < 0 else str(point_limit) + " POINTS"

#Play audio and animations
func _on_go_back_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_low.mp3")
	#Await until animation is done playing before changing scenes
	await GlobalAnimationPlayer.play_animation(go_back_button_control)
	get_tree().change_scene_to_file("res://customization/customization.tscn")
