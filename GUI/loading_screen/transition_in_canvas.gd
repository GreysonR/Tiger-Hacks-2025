extends CanvasLayer

signal animation_finished()

func _on_transition_in_animation_finished() -> void:
	animation_finished.emit()
