extends CharacterBody2D

@onready var die_sfx = $dieSFX
@export var speed: float = 165.0
@export var jump_velocity: float = -200.0
@export var double_jump_velocity: float = -180.0
@export var dead_animation_string: String = "blank"
@export var win: bool = false

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite
@onready var jump_audio = $jumpSFX

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Default to false when you start the game (Because you haven't pressed anything yet) 
var has_double_jumped: bool = false

var animation_locked: bool = false
var direction: Vector2 = Vector2.ZERO
var was_in_air: bool = false

# NOTE BY NATHAN: I created custom key bindings via the project settings, DM me if you have any questions about that
# Jump = Z

func _ready():
	add_to_group("Player")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		if was_in_air == true:
			land()
		
	

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal jump from floor
			jump()
		
		# Checks this statement if you aren't on the floor AND haven't double jumped yet
		elif not has_double_jumped:
			# Double jump in air
			double_jump()
			has_double_jumped = true
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		if dead_animation_string == "dead" || win == true:
			direction = Input.get_vector(" ", " ", " ", " ")
			velocity.x = 0
		else:
			velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 12)
	
	
	move_and_slide()
	update_animation()
	update_facing_direction()
	update_air_animation()


# Determines the idle and running animations
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("running")
		else:
			animated_sprite.play("idle")


# Determines direction your character is facing
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true


# Changes the animation once your y-velocity is making your fall
func update_air_animation():
	if velocity.y > 0 && not animation_locked:
		animation_locked = false
		animated_sprite.play("falling")
		animation_locked = true


# Code for making the character jump ; sets jumping animation
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jumping")
	animation_locked = true
	jump_audio.play()

func death_animation():
	die_sfx.play()
	dead_animation_string = "dead"
	set_process_input(false)
	velocity.y = jump_velocity
	animated_sprite.play("death")
	animation_locked = true

# Code for making the character bounce off an enemy (EXACT same function as jump but WITHOUT jump audio)
func enemy_bounce():
	velocity.y = jump_velocity
	animated_sprite.play("jumping")
	animation_locked = true


# Code for making the character double jump ; sets double jump animation
func double_jump():
	if dead_animation_string == "dead":
		animation_locked == true
	else:
		velocity.y = double_jump_velocity
		animated_sprite.play("double_jumping")
		animation_locked = true
		jump_audio.play()

func win_animation():
	win = true
	animated_sprite.play("win")
	animation_locked = true
	await animated_sprite.animation_finished
	
	
# Once you land, unlock the animation so that the character can change between idle and running again
func land():
	if dead_animation_string == "dead" || win == true:
		animation_locked = true
	else:
		animation_locked = false
