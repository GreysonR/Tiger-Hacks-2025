@tool
extends ActionLeaf

@export var target_radius_range = [250.0, 450.0]

func tick(actor: Node, _blackboard: Blackboard) -> int:
	var target_radius = randf_range(target_radius_range[0], target_radius_range[1])
	var target_angle = randf_range(0, PI/2) + PI/2
	if randf() < 0.5: # choose other side
		target_angle += PI
	var target_pos = Vector2.from_angle(target_angle) * target_radius
	
	actor.target_relative_position = target_pos
	
	return SUCCESS
