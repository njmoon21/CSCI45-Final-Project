extends Area2D

@onready var timer: Timer = $Timer
func _on_body_entered(body: Node2D) -> void:
	body.get_node("CollisionShape2D").queue_free() #removes player collision
	set_process_input(false)
	body.death_animation()
	timer.start()
	

func _on_timer_timeout() -> void: #runs when timer ends
	#Engine.time_scale = 1 #returns speed back to normal
	Transitioner.transition()
	await Transitioner.on_transition_finished
	get_tree().reload_current_scene() #restarts level
