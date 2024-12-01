extends CharacterBody2D
var SPEED = 60
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var die_audio = $dieSFX
@onready var timer = $Hurtbox/Timer
var direction = -1 # -1 to move to the opposite direction
@onready var collision_detection_right: RayCast2D = $"Collision Detection Right"
@onready var collision_detection_left: RayCast2D = $"Collision Detection Left"
@onready var ray_cast_floor: RayCast2D = $RayCastFloor
@onready var ray_cast_floor_2: RayCast2D = $RayCastFloor2
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	add_to_group("Enemy")

func _physics_process(delta):
	# Add the gravity.
	move_and_slide()
	if not is_on_floor():
		velocity.y += gravity * delta

#process runs every frame, so it works for moving enemies
func _process(delta): #delta is the amount of time that has gone by since the last frame (useful for uniform movement)
	position.x += direction * SPEED * delta #adding pixels every frame of movement (SPEED)
	if collision_detection_right.is_colliding():
		direction = -1 # go left
		animated_sprite.flip_h = false # flip sprite
	if collision_detection_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = true #flip back to normal
	if not ray_cast_floor.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
	elif not ray_cast_floor_2.is_colliding():
		direction = -1
		animated_sprite.flip_h = false

func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		var y_delta = position.y - body.position.y
		if (y_delta > 20):
			body.enemy_bounce()
			die_audio.play()
			SPEED = 0
			
			animated_sprite.play("die")
			await animated_sprite.animation_finished
			queue_free()
		else:
			body.get_node("CollisionShape2D").queue_free() #removes player collision
			set_process_input(false)
			body.death_animation()
			timer.start()

func _on_timer_timeout() -> void: #runs when timer ends
	Engine.time_scale = 1 #returns speed back to normal
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
		get_tree().change_scene_to_file("res://Scenes/Screens/Game Over/game_over.tscn")

func death_animation():
	pass
		
