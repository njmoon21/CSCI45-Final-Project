extends Node2D
	
@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var music_player = $Music
@onready var animation_player = $player
@onready var tap_audio = $TapSFX
var paused = false

func _on_tree_entered() -> void:
	if CheckpointManagement.last_position:
		$player.global_position = CheckpointManagement.last_position

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player.play()
	if Globals.first_time_loaded == true:
		Globals.player_lives = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_pause_menu()

	if Input.is_action_just_pressed("pause_quit") && pause_menu.visible == true:
		Engine.time_scale = 1
		pause_menu.hide()
		music_player.stop()
		tap_audio.play()
		
		Transitioner.transition()
		await Transitioner.on_transition_finished
		Globals.first_time_loaded = true
		CheckpointManagement.activated = false
		CheckpointManagement.last_position = null
		MenuMusic.play()
		get_tree().change_scene_to_file("res://Scenes/Menus/Main Menu/main_menu.tscn")


func _pause_menu():
	tap_audio.play()
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		animation_player.set_physics_process(true)
	else:
		pause_menu.show()
		Engine.time_scale = 0
		animation_player.set_physics_process(false)
	paused = !paused
