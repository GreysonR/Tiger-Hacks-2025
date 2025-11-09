extends Node2D

@export var waves: Array[Wave]
@export var wave_n = 0

signal finish_wave(wave, max_waves)

func _ready():
	finish_wave.emit(wave_n + 1, waves.size())
	# spawn first wave
	for wave in waves:
		remove_child(wave)
	
	add_child(waves[wave_n])
	waves[wave_n].connect("completed", next_wave)
	
func next_wave():
	waves[wave_n].disconnect("completed", next_wave)
	waves[wave_n].queue_free()
	
	await get_tree().create_timer(1.5).timeout
	wave_n += 1
	finish_wave.emit(wave_n + 1, waves.size())
	if wave_n >= waves.size():
		print("Done!")
		return
	
	add_child(waves[wave_n])
	waves[wave_n].connect("completed", next_wave)
