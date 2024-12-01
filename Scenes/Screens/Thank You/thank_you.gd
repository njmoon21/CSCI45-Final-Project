extends Control

func _ready():
	MenuMusic.play_menu_music()

func show_title(text):
	$MessageLabel.text = text
	$MessageLabel.show()

func _input(event: InputEvent):
	if event is InputEventKey and event.pressed:
		$TapSFX.play()
		
		Transitioner.transition()
		await Transitioner.on_transition_finished
		
		CheckpointManagement.activated = false
		CheckpointManagement.last_position = null
		
		Globals.player_lives = 3
		
		get_tree().change_scene_to_file("res://Scenes/Menus/Main Menu/main_menu.tscn")
