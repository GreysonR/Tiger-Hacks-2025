extends RigidBody2D

@onready var player = get_tree().get_first_node_in_group("PlayerCharacter")
const pickup_distance = 250.0
const pickup_strength = 400.0

var initial_velocity = Vector2.ZERO

func _ready():
	linear_velocity = initial_velocity

func _integrate_forces(state: PhysicsDirectBodyState2D):
	var distance = player.global_position - global_position
	if distance.length() < pickup_distance:
		state.apply_force(distance.normalized() * pickup_strength, state.center_of_mass)
	state.linear_velocity *= 0.99


func _on_hitbox_touched(node: Node2D) -> void:
	if node.is_in_group("Player"):
		queue_free()
