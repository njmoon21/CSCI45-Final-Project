extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	add_to_group("Enemy")

func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		animated_sprite.play("die")
		await animated_sprite.animation_finished
		queue_free()
		
