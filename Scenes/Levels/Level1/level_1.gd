extends Node2D

@onready var pause_menu = $pause_menu
@onready var music_player = $Music

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pass
		

func PauseMenu():
	pass
