extends Area2D

@onready var timer: Timer = $Timer
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.get_node("CollisionShape2D").queue_free() #removes player collision
		body.death_animation()
		timer.start()
	

func _on_timer_timeout() -> void: #runs when timer ends
	#Engine.time_scale = 1 #returns speed back to normal
	Transitioner.transition()
	await Transitioner.on_transition_finished
	Globals.first_time_loaded = false
	Globals.player_lives -= 1
	
	# If you still have extra lives, reload and keep playing ----> Otherwise, show game over screen
	if Globals.player_lives > 0:
		print("Reloading Scene")
		get_tree().reload_current_scene() #restarts level
	else:
		print("Game Over")
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/Screens/game_over.tscn")
