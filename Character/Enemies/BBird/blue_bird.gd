extends CharacterBody2D
@onready var die_audio: AudioStreamPlayer = $dieSFX
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
			body.enemy_bounce()
			die_audio.play()
			animated_sprite.play("die")
			await animated_sprite.animation_finished
			queue_free()
