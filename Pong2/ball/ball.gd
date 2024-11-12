class_name Ball
extends CharacterBody2D

@export var speed := 400


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision:
		velocity = velocity * 1.075
		velocity = velocity.bounce(collision.get_normal())
		AudioManager.audio_play("res://assets/Audio/ping_pong_8bit_plop.ogg")

#Stop the ball
func stop_moving() -> void:
	velocity = Vector2.ZERO

#Pick a random direction to start the ball movement
func start_moving() -> void:
	velocity.x = [-1, 1].pick_random()
	velocity.y = [-0.8, 0.8].pick_random()
	velocity = velocity * speed

#Reset the ball's position
func reset_ball() -> void:
	stop_moving()
	speed = 400
	position = get_viewport_rect().size / 2
