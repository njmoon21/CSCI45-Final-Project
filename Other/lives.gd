extends Control

func _process(delta):
	$Label.text = "Lives: " + str(Globals.player_lives)
