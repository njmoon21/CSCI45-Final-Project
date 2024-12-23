extends Control

@onready var tap_audio = $TapSFX
@onready var back_button = $BackButton
@onready var check_button = $CheckButton

func _ready():
	back_button.grab_focus()
	$MasterVolumeSlide.value = Globals.master_volume
	$MusicVolumeSlide.value = Globals.music_volume
	$SFXVolumeSlide.value = Globals.sfx_volume
	
	# I use the set_pressed built-in function to determine true or false depending on the argument from the Global var
	check_button.set_pressed(Globals.fullscreen_button_state)

func show_title(text):
	$MessageLabel.text = text
	$MessageLabel.show()

func _on_button_pressed():
	tap_audio.play()
	Globals.master_volume = $MasterVolumeSlide.value
	Globals.music_volume = $MusicVolumeSlide.value
	Globals.sfx_volume = $SFXVolumeSlide.value
	
	# Different method compared to the sliders. I have to use the "is_pressed()" built in function to return a bool function and set it to the Global var
	Globals.fullscreen_button_state = check_button.is_pressed()
	
	Transitioner.transition()
	await Transitioner.on_transition_finished
	
	get_tree().change_scene_to_file("res://Scenes/Menus/Main Menu/main_menu.tscn")

func _on_check_button_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_check_button_pressed():
	tap_audio.play()

# Plays audio when navigating through all the buttons in the menu
func _on_back_button_focus_entered():
	tap_audio.play()
func _on_master_volume_slide_focus_entered():
	tap_audio.play()
func _on_music_volume_slide_focus_entered():
	tap_audio.play()
func _on_sfx_volume_slide_focus_entered():
	tap_audio.play()
func _on_check_button_focus_entered():
	tap_audio.play()

# Plays audio when changing the values of each slider
func _on_master_volume_slide_value_changed(value: float):
	tap_audio.play()
func _on_music_volume_slide_value_changed(value: float):
	tap_audio.play()
func _on_sfx_volume_slide_value_changed(value: float):
	tap_audio.play()
