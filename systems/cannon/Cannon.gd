extends Node2D
class_name Cannon

const CannonballScene = preload("res://cannonball/cannonball.tscn")
const CannonFireParticlesScene = preload("res://cannonball/hit_effects/cannon_fire_particles.tscn")

@onready var player = get_tree().get_first_node_in_group("PlayerCharacter")

@export var damage: int = 1 ## Damage dealt by cannonball
@export var fire_rate: float = 1000.0 ## ms per shot
@export var side: int = 0 ## What side the cannon is on. Use if you only want to fire one side at a time, or create firing groups. Keep unique if you want to fire only one cannon at a time
@export var speed: float = 350.0 ## Speed of cannonball
@export_range (0.0, 180.0, 1.0) var angle_range: float = 90.0 ## Angle between which the cannon can actually shoot

@export_flags_2d_physics var collision_layer: int = 1
@export_flags_2d_physics var collision_mask: int = 1

@export var parent_collision_shape: CollisionObject2D

@export var animation_player: AnimationPlayer
@export var idle_animation_name: String = "idle"
@export var shoot_animation_name: String = "shoot"

@onready var last_fired = -fire_rate ## When the cannon was last shot

func _ready():
	if animation_player:
		animation_player.connect("animation_finished", switch_to_idle)
		animation_player.speed_scale = 1000.0 / fire_rate # speed up or down based on fire rate
	else:
		print_rich("[b][color=red]NO ANIMATION PLAYER SPECIFIED IN CANNON[/color][/b]")

func switch_to_idle(_x):
	animation_player.current_animation = idle_animation_name

var can_shoot: bool:
	get:
		return Time.get_ticks_msec() - last_fired >= fire_rate

func shoot(target: Vector2, additional_vel: Vector2 = Vector2.ZERO) -> bool:
	if !can_shoot:
		return false
	
	var dir = (target - global_position).normalized()
	
	# Ensure you're firing within its allowed angle
	if abs(angle_difference(dir.angle(), global_rotation)) > deg_to_rad(angle_range) / 2.0:
		return false
	
	#print("Shot to ", dir)
	
	last_fired = Time.get_ticks_msec()
	
	# Create cannonball
	var cannonball = CannonballScene.instantiate()
	cannonball.parent_collision_shape = parent_collision_shape
	cannonball.position = global_position
	cannonball.set_mask(collision_mask)
	cannonball.set_layer(collision_layer)
	cannonball.velocity = dir * speed + additional_vel
	get_tree().root.add_child(cannonball)
	
	# Animate sprite
	if animation_player:
		animation_player.current_animation = shoot_animation_name
		
	# Add particle effect
	var particles = CannonFireParticlesScene.instantiate()
	particles.position = Vector2.ZERO
	particles.restart()
	add_child(particles)
	
	return true
	
