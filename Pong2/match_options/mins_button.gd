extends Button


	
@export var light = self.icon
@export var dark = self.icon
@export var mins : int = -1
@export var description : String = "PLACEHOLDER_CHANGE_ME"
@onready var current_time_selection_icon: TextureRect = %current_time_selection_icon
@onready var current_time_selection_label: Label = %current_time_selection_label
@onready var button_sound: AudioStreamPlayer = $button_sound


func _on_pressed() -> void:
	button_sound.play()
	GlobalAnimationPlayer.play_animation(self)
	#Set the text, variable and icon for the current time limit selection
	current_time_selection_label.text = "NO TIME LIMIT" if mins < 0 else str(mins) + " MINUTES"
	current_time_selection_icon.texture = dark
	GameManager.time_limit = mins
	GameManager.time_icon = dark

#Alternate between light and dark icons
func _on_mouse_entered() -> void:
	self.icon = light

#Alternate between light and dark icons
func _on_mouse_exited() -> void:
	self.icon = dark
