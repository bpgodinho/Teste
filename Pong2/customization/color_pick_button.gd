extends Button

@export var player := 1
@onready var player_1_preview: ColorRect = %player1_preview
@onready var player_2_preview: ColorRect = %player2_preview


@export var btn_color : Color

func _ready() -> void:
	#Disables the second set of buttons for multiplayer
	if player == 2 && !GameManager.pvp:
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#Changes styles programatically to avoid customizing focus hover and other cases
	btn_color = self.get_theme_stylebox("normal").bg_color
	self.get_theme_stylebox("pressed").bg_color = btn_color
	self.get_theme_stylebox("hover").bg_color = btn_color
	self.get_theme_stylebox("hover_pressed").bg_color = btn_color

func _on_pressed() -> void:
	if player == 1:
		#Set color in preview and GameManager of the relevant player to the color of the pressed button
		player_1_preview.color = btn_color
	else:
		#Set color in preview and GameManager of the relevant player to the color of the pressed button
		player_2_preview.color = btn_color
