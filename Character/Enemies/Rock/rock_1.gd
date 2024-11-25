extends CharacterBody2D

@onready var timer: Timer = $Hurtbox/Timer
@export var speed = 250.0
var current_speed = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timer_2: Timer = $Timer2
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var animation_locked: bool = false
var player_dead: String = "blank"

func _ready():
	add_to_group("Player")

func _physics_process(delta):
	if player_dead == "dead":
		velocity.x = 0
		move_and_slide()
		velocity.y = -50
	else:
		move_and_slide()
		if is_on_floor():
			animation_locked = false
			velocity.y = -50
			velocity.x = 0
			animated_sprite.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("He's here")
		if not velocity.y == -50:
			fall()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	velocity.x = 0
	if body.name == "player":
		body.get_node("CollisionShape2D").queue_free() #removes player collision
		player_dead = "dead"
		body.death_animation()
		timer.start()
	
func _on_timer_timeout() -> void:
	Transitioner.transition()
	await Transitioner.on_transition_finished
	get_tree().reload_current_scene() #restarts level

func fall():
	velocity.y = speed
	velocity.x = 0
	animated_sprite.play("fall")
	animation_locked = true
