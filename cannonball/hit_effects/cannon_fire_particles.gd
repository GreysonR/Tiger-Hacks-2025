extends GPUParticles2D

func _ready():
	one_shot = true



func _on_finished() -> void:
	queue_free()
