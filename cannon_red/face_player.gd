@tool
extends ActionLeaf

@export var turn_rate : float = 0.5

func tick(actor: Node, _blackboard: Blackboard) -> int:
	var target_angle = (actor.player.global_position - actor.global_position).angle()
	var current_angle = actor.rotation
	var angle_diff = angle_difference(target_angle, current_angle)
	#var turn_dir = sign(angle_diff)
	
	if angle_diff < 0.05:
		return SUCCESS
	
	actor.rotation = rotate_toward(current_angle, target_angle, turn_rate)	
	
	return RUNNING
