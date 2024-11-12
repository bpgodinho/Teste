extends TextureRect

@onready var main_menu_control: Control = $VBoxContainer/MainMenuControl

func _on_main_menu_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_high.mp3")
	await GlobalAnimationPlayer.play_animation(main_menu_control)
	GameManager.reset()
	AudioManager.change_music("res://assets/Audio/GD_menu_theme.mp3")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
