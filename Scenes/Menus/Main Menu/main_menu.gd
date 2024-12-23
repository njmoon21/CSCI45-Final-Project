extends Control

@onready var tap_audio = $TapSFX
@onready var start_button = $startButton



## Called when the node enters the scene tree for the first time.
func _ready():
	MenuMusic.play_menu_music()
	start_button.grab_focus()


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


# Show the name of the Game
func show_title(text):
	$MessageLabel.text = text
	$MessageLabel.show()

# Pressing Play
func _on_start_button_pressed():
	MenuMusic.stop()
	tap_audio.play()
	
	Transitioner.transition()
	await Transitioner.on_transition_finished
	
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1/level1.tscn")

# Pressing Settings
func _on_settings_button_pressed():
	tap_audio.play()
	
	Transitioner.transition()
	await Transitioner.on_transition_finished
	
	get_tree().change_scene_to_file("res://Scenes/Menus/Settings Menu/settings_menu.tscn")

# Pressing Quit
func _on_quit_button_pressed():
	tap_audio.play()
	
	Transitioner.transition()
	await Transitioner.on_transition_finished
	
	get_tree().quit()

# Plays audio when navigating through all the buttons in the menu
func _on_start_button_focus_entered():
	tap_audio.play()
func _on_settings_button_focus_entered():
	tap_audio.play()
func _on_quit_button_focus_entered():
	tap_audio.play()
