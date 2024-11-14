extends Control

@onready var tap_audio = $TapSFX

func show_title(text):
	$MessageLabel.text = text
	$MessageLabel.show()

func _on_button_pressed():
	tap_audio.play()
	
	Transitioner.transition()
	await Transitioner.on_transition_finished
	
	get_tree().change_scene_to_file("res://Scenes/Menus/Main Menu/main_menu.tscn")
