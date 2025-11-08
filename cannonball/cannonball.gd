extends Node2D

@export var damage: int = 1
@export var knockback: float = 0.0
@onready var hitbox = %Hitbox

@onready var explosion_scene = preload("res://cannonball/hit_effects/normal_cannonballexplosion.tscn")

var parent_collision_shape: CollisionObject2D
var velocity = Vector2.ZERO
var mask = 0
var layer = 0

func _ready():
	hitbox.damage = damage
	hitbox.knockback = knockback
	
	hitbox.collision_layer = layer
	hitbox.collision_mask = mask
	
	await get_tree().create_timer(8.0).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:
	position += velocity * delta


func _on_hitbox_entered(body) -> void:
	if body == parent_collision_shape:
		return
	
	# Trigger explosion
	var explosion = explosion_scene.instantiate()
	explosion.position = position
	explosion.rotation = velocity.angle() + PI
	get_tree().root.add_child(explosion)
	
	# Delete cannonball
	queue_free()

func set_layer(new_layer):
	layer = new_layer
	if hitbox:
		hitbox.collision_layer = new_layer
func set_mask(new_mask):
	mask = new_mask
	if hitbox:
		hitbox.collision_mask = new_mask


func _on_hitbox_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	_on_hitbox_entered(body)

func _on_hitbox_dealt_damage(hurtbox: Hurtbox) -> void:
	_on_hitbox_entered(hurtbox)
