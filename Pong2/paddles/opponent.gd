extends CharacterBody2D

@export var speed := 250
@export var ball: Node2D
var direction := 0.0
@onready var color_rect: ColorRect = $ColorRect

#Set speed based on difficulty
func _ready() -> void:
	speed = 200 + (GameManager.dificulty * 100)
	color_rect.color = GameManager.player_2_color
	


func _physics_process(delta: float) -> void:
		velocity.x = 0
		velocity.y = direction * 400 if GameManager.pvp else get_direction() * speed
		move_and_collide(velocity * delta)


func _unhandled_input(_event: InputEvent) -> void:
	direction = Input.get_axis("player2_up", "player2_down")


func get_direction() -> int:
	var deadzone := 10
	
	# If the ball is above, return -1 (move paddle up)
	if ball.position.y - position.y < -deadzone:
		return -1
		
	#If the ball is below, return 1 (move paddle down)
	elif ball.position.y - position.y > deadzone:
		return 1
	
	# Else return 0 (dont' move paddle) 
	return 0
