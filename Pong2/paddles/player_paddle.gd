extends CharacterBody2D

@export var speed := 400
var direction := 0.0
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	color_rect.color = GameManager.player_1_color
	

func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.y = direction * speed
	#move_and_slide()
	move_and_collide(velocity * delta)


func _unhandled_input(_event: InputEvent) -> void:
	direction = Input.get_axis("ui_up", "ui_down")
