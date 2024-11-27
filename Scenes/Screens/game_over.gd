extends Control


func _ready():
	$GameOverMusic.play()

func show_title(text):
	$MessageLabel.text = text
	$MessageLabel.show()

func _input(event: InputEvent):
	if event is InputEventKey and event.pressed:
		$GameOverMusic.stop()
		$TapSFX.play()
		
		Transitioner.transition()
		await Transitioner.on_transition_finished
		
		CheckpointManagement.activated = false
		CheckpointManagement.last_position = null
		
		Globals.player_lives = 3
		
		MenuMusic.play()
		
		get_tree().change_scene_to_file("res://Scenes/Menus/Main Menu/main_menu.tscn")
