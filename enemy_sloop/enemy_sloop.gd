extends CharacterBody2D

signal died(node)

@export var ship: Ship
@onready var boost_sprite = %BoostSprite
@onready var healthbar = %Healthbar

@onready var player: Ship = get_tree().get_first_node_in_group("PlayerCharacter")
@onready var navigation_agent: NavigationAgent2D = %NavigationAgent2D

@onready var ExplosionScene = preload("res://cannonball/hit_effects/radial_cannonball_explosion.tscn")

# AI settings
@export var shoot_range: float = 700.0
@onready var behavior_tree: BeehaveTree = %BeehaveTree

# AI controls
var turn_dir = 0
var forward_dir = 0
var target_relative_position = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if !player:
		boost_sprite.visible = false
		return
	var ship_dir = Vector2.from_angle(rotation)
	var acceleration = ship.acceleration
	
	navigation_agent.target_position = target_relative_position.rotated(player.parent_body.rotation) + player.global_position
	navigation_agent.get_next_path_position() # for debug
	
	# Shoot if possible
	var player_dist = (player.global_position - global_position).length()
	if player_dist < shoot_range:
		var target = player.global_position + player.parent_body.velocity * player_dist / 350.0 - velocity * 0.5
		ship.shoot_cannons(target)
	
	# Slow down turn rate if going very slow
	var turn_slowing = min(1.0, velocity.length() / ship.turn_threshold)
	
	# Don't go as fast if moving backward / braking
	if forward_dir < 0.0:
		acceleration *= ship.backward_multiplier
		
	# Reverse steer controls when going backwards
	if ship_dir.dot(velocity) < 0.0:
		turn_dir *= -1
	
	# Apply velocities
	velocity += acceleration * forward_dir * ship_dir
	rotation += ship.turn_rate/1000.0 * turn_dir * turn_slowing
	
	# Apply friction
	velocity *= (1 - ship.friction) ** delta
	
	
	# Change boost sprite
	boost_sprite.visible = forward_dir > 0
	
	# Have healthbar follow
	healthbar.rotation = -rotation
	
	move_and_slide()


func _on_ship_damaged(new_health: int, _damage: int) -> void:
	healthbar.set_health(new_health, ship.max_health)


func _on_ship_died(_node) -> void:
	died.emit(self)
	queue_free()
	var explosion = ExplosionScene.instantiate()
	explosion.position = global_position
	get_tree().root.add_child(explosion)
