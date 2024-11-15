extends Control

@onready var tap_audio = $TapSFX

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

# Show the name of the Game
func show_title(text):
	$MessageLabel.text = text
	$MessageLabel.show()

# Pressing Play
func _on_start_button_pressed():
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
