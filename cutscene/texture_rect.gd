extends TextureRect

func _physics_process(delta):
	position.y += delta * 300
