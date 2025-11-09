extends AnimatedSprite2D


func _on_animation_finished() -> void:
	get_parent().queue_free()
