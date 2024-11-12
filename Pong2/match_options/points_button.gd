extends Button

@export var light = self.icon
@export var dark = self.icon
@export var points : int = -1
@export var description : String = "PLACEHOLDER_CHANGE_ME"
@onready var current_points_selection_icon: TextureRect = %current_points_selection_icon
@onready var current_points_selection_label: Label = %current_points_selection_label
@onready var button_sound: AudioStreamPlayer = $button_sound


func _on_pressed() -> void:
	button_sound.play()
	GlobalAnimationPlayer.play_animation(self)
	current_points_selection_label.text = "NO POINT LIMIT" if points < 0 else str(points) + " POINTS"
	current_points_selection_icon.texture = dark
	GameManager.point_limit = points
	GameManager.points_icon = dark


func _on_mouse_entered() -> void:
	self.icon = light


func _on_mouse_exited() -> void:
	self.icon = dark
