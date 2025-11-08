extends Node2D

var num_running = 2

signal finish()


func _ready():
	%Bottom.one_shot = true
	%Top.one_shot = true
	
	%Bottom.restart()
	%Top.restart()

func _on_finish() -> void:
	num_running -= 1
	
	if num_running == 0:
		finish.emit()
		queue_free()
