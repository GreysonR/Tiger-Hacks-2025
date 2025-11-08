extends CharacterBody2D

@export var ship: Ship

@onready var boost_sprite = %BoostSprite

signal move(new_position: Vector2)

func _physics_process(delta: float) -> void:
	var ship_dir = Vector2.from_angle(rotation)
	var forward_dir = Input.get_axis("backward", "forward")
	var turn_dir = Input.get_axis("turn_left", "turn_right")
	var acceleration = ship.acceleration
	
	# Slow down turn rate if going very slow
	var turn_slowing = min(1.0, velocity.length() / ship.turn_threshold)
	
	# Don't go as fast if moving backward
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
	
	if velocity.length() > 0:
		move.emit(global_position)
		
	# Change boost sprite
	boost_sprite.visible = forward_dir > 0
		
	
	move_and_slide()
