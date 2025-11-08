extends CharacterBody2D

@export var ship: Ship

@onready var boost_sprite = %BoostSprite

signal move(new_position: Vector2)
signal damaged(new_health: int, damage: int, max_health: int)
signal died()
signal collected_coin()

func _physics_process(delta: float) -> void:
	var ship_dir = Vector2.from_angle(rotation)
	var forward_dir = Input.get_axis("backward", "forward")
	var turn_dir = Input.get_axis("turn_left", "turn_right")
	var acceleration = ship.acceleration
	
	# Shoot if possible
	if Input.is_action_just_pressed("shoot"):
		var target = get_global_mouse_position()
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
	
	if velocity.length() > 0:
		move.emit(global_position)
		
		
	# Change boost sprite
	boost_sprite.visible = forward_dir > 0
		
	
	move_and_slide()


func _on_ship_damaged(new_health: int, damage: int) -> void:
	damaged.emit(new_health, damage, ship.max_health)


func _on_ship_died() -> void:
	died.emit()

func collect_coin():
	PlayerStats.money += 1
	collected_coin.emit()


func _on_hurtbox_touched(node: Node2D) -> void:
	if node.is_in_group("Coin"):
		collect_coin()
