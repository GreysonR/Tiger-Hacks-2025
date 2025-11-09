extends Node

var current_scene: Node = null
var loading_scene = preload("res://GUI/loading_screen/loading_screen.tscn")

signal unload()

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	get_tree().set_current_scene(current_scene)

func switch_to(res_path: String) -> void:
	print("Switching to", res_path)
	call_deferred("_deferred_switch_to", res_path)

func _deferred_switch_to(res_path: String) -> void:
	_instant_switch_to(loading_scene)

	ResourceLoader.load_threaded_request(res_path)
	var progress = []
	while true:
		var status = ResourceLoader.load_threaded_get_status(res_path, progress)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			break
		await get_tree().create_timer(0.05).timeout

	var packed_scene = ResourceLoader.load_threaded_get(res_path)
	if packed_scene:
		_instant_switch_to(packed_scene)
	else:
		push_error("Failed to load scene: " + res_path)

func _instant_switch_to(scene: PackedScene) -> void:
	unload.emit()
	if current_scene:
		current_scene.queue_free()
		await current_scene.tree_exited  # wait for the old scene to fully leave the tree

	var root := get_tree().root
	current_scene = scene.instantiate()
	root.add_child(current_scene)
	get_tree().set_current_scene(current_scene)


func switch_to_home():
	await get_tree().create_timer(2).timeout
	transition_out(_post_switch_to_home)
		
func _post_switch_to_home():
	SceneSwitcher.switch_to("res://main.tscn")


@onready var transition_in_scene = preload("res://GUI/loading_screen/transition_in.tscn")
@onready var transition_out_scene = preload("res://GUI/loading_screen/transition_out.tscn")
func transition_in(callback):
	var obj = transition_in_scene.instantiate()
	get_tree().root.add_child(obj)
	if callback:
		obj.connect("animation_finished", callback)

func transition_out(callback):
	var obj = transition_out_scene.instantiate()
	get_tree().root.add_child(obj)
	
	if callback:
		obj.connect("animation_finished", callback)
