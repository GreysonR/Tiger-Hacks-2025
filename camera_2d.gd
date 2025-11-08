extends Camera2D

@onready var player = %Player

func _ready():
	jump_to_player_position()
	
func jump_to_player_position():
	position = player.global_position
	reset_smoothing()

func _on_player_move(new_position: Vector2) -> void:
	position = Vector2(new_position)
