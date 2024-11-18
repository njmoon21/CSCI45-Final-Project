extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var die_audio = $dieSFX

func _ready():
	add_to_group("Enemy")

func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		var y_delta = position.y - body.position.y
		if (y_delta > 20):
			print("Destroy Enemy")
			body.enemy_bounce()
			die_audio.play()
			
			animated_sprite.play("die")
			await animated_sprite.animation_finished
			queue_free()
		else:
			print("Hitting Enemy from sides")
		#animated_sprite.play("die")
		#await animated_sprite.animation_finished
		#queue_free()
		
