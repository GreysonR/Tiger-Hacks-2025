extends Character
class_name Ship

@export var acceleration: float = 11.0 ## Acceleration forwards, px/s^2
@export var turn_rate: float = 19 ## Turn rate in radians, divided by 1000
@export var friction = 0.85 ## Percent slowed per second
@export var turn_threshold = 400.0 ## Speed at which turn speed starts being reduced
@export var backward_multiplier = 0.3 ## How much to multiply vel if going backward

@export var shoot_all: bool = true ## If to shoot all cannons at once, or one at a time

@export var cannons: Array[Cannon]

func shoot_cannons(target: Vector2):
	var addon_vel = parent_body.velocity * 0.5 # idk if to enable this or not
	for cannon in cannons:
		var shot_successfully = cannon.shoot(target, addon_vel)
		if !shoot_all && shot_successfully: # Only shoot 1 cannon
			break
