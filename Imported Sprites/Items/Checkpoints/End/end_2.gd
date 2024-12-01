extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ending: AudioStreamPlayer = $Ending


@export var target_level : PackedScene # for level switching or ending game
# Called when the node enters the scene tree for the first time.
func _on_ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "player"):
		animated_sprite_2d.play("win")
		ending.play()
		Engine.time_scale = 0.7
		body.win_animation()
		await animated_sprite_2d.animation_finished
		await body.win_animation()
		Engine.time_scale = 1
		Transitioner.transition()
		await Transitioner.on_transition_finished
		CheckpointManagement.activated = false
		CheckpointManagement.last_position = null
		Globals.first_time_loaded = true
		MenuMusic.play()
		get_tree().change_scene_to_packed(target_level)
