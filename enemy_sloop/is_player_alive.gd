@tool
extends ConditionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.player and actor.player.is_inside_tree():
		return SUCCESS
	return FAILURE
