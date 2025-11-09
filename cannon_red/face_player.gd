@tool
extends ActionLeaf

@export var turn_rate : float = 1.0

func tick(actor: Node, blackboard: Blackboard) -> int:
	if !actor.player or !actor.player.is_inside_tree():
		return FAILURE
	var target_angle = (actor.player.global_position - actor.global_position).angle()
	var current_angle = actor.global_rotation
	var angle_diff = angle_difference(target_angle, current_angle)
	#var turn_dir = sign(angle_diff)
	
	if abs(angle_diff) < 0.05:
		blackboard.set_value("target_position", actor.player.global_position)
		return SUCCESS
	
	actor.global_rotation = rotate_toward(current_angle, target_angle, turn_rate * actor.delta_time)
	
	return RUNNING
