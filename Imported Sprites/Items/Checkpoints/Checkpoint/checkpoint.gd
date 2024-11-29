extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var active: bool = false


func _on_body_entered(body):
	if CheckpointManagement.activated == true:
		animated_sprite_2d.play("idle2")
	if body.name == "player" && active == false:
		$CheckpointSFX.play()
		active = true
		CheckpointManagement.last_position = global_position
		animated_sprite_2d.play("activated")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("idle2")
		CheckpointManagement.activated = true
