extends Node
var current_scene = null

var loading_scene = preload("res://GUI/loading_screen/loading_screen.tscn")

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_to(res_path: String):
	print("Switching to ", res_path)
	call_deferred("_deferred_switch_to", res_path)
	
func _deferred_switch_to(res_path: String):
	await _instant_switch_to(loading_scene)
	
	ResourceLoader.load_threaded_request(res_path)
	
	var progress = []
	while true:
		ResourceLoader.load_threaded_get_status(res_path, progress)
		#progress_bar.update_percent(progress[0])
		if progress[0] == 1.0:
			break
		await get_tree().create_timer(0.05).timeout
		
	var s = ResourceLoader.load_threaded_get(res_path)
	_instant_switch_to(s)

func _instant_switch_to(scene: PackedScene):
	if current_scene:
		current_scene.queue_free()

	current_scene = scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().root.move_child(current_scene, get_tree().root.get_child_count() - 1)
	get_tree().set_current_scene(current_scene)
