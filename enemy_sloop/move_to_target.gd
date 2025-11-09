@tool
extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	var navigation_agent: NavigationAgent2D = actor.navigation_agent;
	var next_pos = navigation_agent.get_next_path_position()
	var cur_angle = actor.rotation
	var target_diff: Vector2 = next_pos - actor.global_position
	var target_angle = target_diff.angle()
	var angle_diff = angle_difference(cur_angle, target_angle)
	
	if (navigation_agent.target_position - actor.global_position).length() < 200.0:
		return SUCCESS
	
	if abs(angle_diff) < 0.05:
		angle_diff = 0
	actor.turn_dir = sign(angle_diff)
	
	actor.forward_dir = 1
	if abs(angle_diff) > PI * 0.7: # almost directly behind
		actor.forward_dir = -1
		actor.turn_dir *= -1 # turning is reversed
	
	return RUNNING
