extends Node2D
class_name Wave

signal completed()

var children = []
var children_alive = 0

func _ready():
	for child in get_children():
		if child.name == "View":
			continue
		if !child.has_signal("died"):
			print("ERROR: child doesn't have signal 'died': ", child)
		child.connect("died", _on_child_die)
		if !child.is_in_group("Unnecessary"):
			children_alive += 1

func _on_child_die(child):
	if !child.is_in_group("Unnecessary"):
		children_alive -= 1
	
	if children_alive <= 0:
		completed.emit()
