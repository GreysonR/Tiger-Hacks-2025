extends Node2D

func _ready():
	SceneSwitcher.transition_in(null)

func _physics_process(_delta: float) -> void:
	if OS.is_debug_build() && Input.is_action_just_pressed("quit"):
		get_tree().quit()
