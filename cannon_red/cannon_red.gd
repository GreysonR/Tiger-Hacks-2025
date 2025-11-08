extends CharacterBody2D

@export var character: Character

@onready var cannon = %Cannon
@onready var player = get_tree().get_first_node_in_group("PlayerCharacter")
@onready var healthbar = %Healthbar

@onready var ExplosionScene = preload("res://cannonball/hit_effects/radial_cannonball_explosion.tscn")

func _on_character_damaged(new_health: int, _damage: int) -> void:
	healthbar.set_health(new_health, character.max_health)

func _on_character_died() -> void:
	queue_free()
	var explosion = ExplosionScene.instantiate()
	explosion.position = global_position
	get_tree().root.add_child(explosion)
