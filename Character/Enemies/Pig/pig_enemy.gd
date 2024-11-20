extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var die_audio = $dieSFX
@onready var timer = $Hurtbox/Timer
func _ready():
	add_to_group("Enemy")

func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		var y_delta = position.y - body.position.y
		if (y_delta > 19.9):
			body.enemy_bounce()
			die_audio.play()
			
			animated_sprite.play("die")
			await animated_sprite.animation_finished
			queue_free()
		else:
			body.get_node("CollisionShape2D").queue_free() #removes player collision
			set_process_input(false)
			body.death_animation()
			timer.start()
	

func _on_timer_timeout() -> void: #runs when timer ends
	#Engine.time_scale = 1 #returns speed back to normal
	Transitioner.transition()
	await Transitioner.on_transition_finished
	get_tree().reload_current_scene() #restarts level

		
