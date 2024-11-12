extends AnimationPlayer

@onready var animation_player: AnimationPlayer = $"."

func play_animation(target, animation : String = "button_press"):
	#Get path of the node
	animation_player.root_node = target.get_path()
	#Stop the current animation to avoid queueing animations
	animation_player.stop(true)
	animation_player.play(animation, -1, 3)
	#return a signal to avoid switching scenes instantly
	return animation_player.animation_finished
