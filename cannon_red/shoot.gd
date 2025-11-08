@tool
extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.shoot(blackboard.get_value("target_position"))
	return SUCCESS
