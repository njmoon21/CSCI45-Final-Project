extends CharacterBody2D
@onready var timer: Timer = $Hurtbox/Timer
@export var speed = 250.0
var current_speed = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var animation_locked: bool = false
var player_dead: String = "blank"

func _ready():
	add_to_group("Player")

func _physics_process(delta):
	move_and_slide()
	if player_dead == "dead":
		velocity.x = 0
		velocity.y = -50
	else:
		if is_on_floor():
			animation_locked = false
			velocity.y = -50
			velocity.x = 0
			animated_sprite.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if not velocity.y == -50:
			fall()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	velocity.x = 0
	if body.name == "player":
		body.get_node("CollisionShape2D").queue_free() #removes player collision
		player_dead = "dead"
		animation_locked = false
		animated_sprite.play("idle")
		body.death_animation()
		timer.start()
	
func _on_timer_timeout() -> void:
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


func fall():
	velocity.y = speed
	velocity.x = 0
	animated_sprite.play("fall")
	animation_locked = true
