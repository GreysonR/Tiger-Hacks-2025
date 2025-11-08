extends Character
class_name Ship

@export var acceleration: float = 11.0
@export var turn_rate: float = 18
@export var friction = 0.85 # percent slowed per second
@export var turn_threshold = 400.0
@export var backward_multiplier = 0.2 # How much to multiply vel if going backward
