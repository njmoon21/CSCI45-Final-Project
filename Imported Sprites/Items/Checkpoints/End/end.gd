extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var target_level : PackedScene # for level switching or ending game
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "player"):
		animated_sprite_2d.play("win")
		await animated_sprite_2d.animation_finished
		Transitioner.transition()
		await Transitioner.on_transition_finished
		CheckpointManagement.activated = false
		CheckpointManagement.last_position = null
		get_tree().change_scene_to_packed(target_level)
