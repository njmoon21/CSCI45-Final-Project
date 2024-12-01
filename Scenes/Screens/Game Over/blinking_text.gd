extends Label

func _on_timer_timeout() -> void:
	self.visible = not self.visible
