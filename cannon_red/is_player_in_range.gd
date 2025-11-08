@tool
extends ConditionLeaf

const max_fire_distance = 600.0

func tick(actor: Node, blackboard: Blackboard) -> int:
	var player = actor.player
	var diff = player.global_position - actor.global_position
	
	if diff.length() < max_fire_distance:
		return SUCCESS
	return FAILURE
