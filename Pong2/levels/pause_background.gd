extends TextureRect

@onready var continue_button: Button = $VBoxContainer/continue_button
@onready var main_menu_button: Button = $VBoxContainer/main_menu_button

var x = 150
var y = 30.5

func _ready() -> void:
	#Set pivot offsets for relevant buttons
	var buttons = [continue_button, main_menu_button]
	for button in buttons:
		button.pivot_offset.x = x
		button.pivot_offset.y = y

func _process(delta: float) -> void:
	#Pause game and show pause menu
	if Input.is_key_pressed(KEY_P) && get_tree().paused == false:
		get_tree().paused = true
		show()


func _on_main_menu_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_low.mp3")
	
	await GlobalAnimationPlayer.play_animation(main_menu_button)
	#Unpause game and
	get_tree().paused = false
	AudioManager.change_music("res://assets/Audio/GD_menu_theme.mp3")
	GameManager.reset()
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func _on_continue_button_pressed() -> void:
	AudioManager.audio_play("res://assets/Audio/button_high.mp3")
	await GlobalAnimationPlayer.play_animation(continue_button)
	get_tree().paused = false
	hide()
