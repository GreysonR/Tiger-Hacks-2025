extends Node2D
class_name Character

signal damaged(new_health: int, damage: int)

@export var parent_body: CharacterBody2D
@export var max_health: int = 20
@onready var health: int = max_health

func take_damage(damage: int):
	var damage_dealt = min(damage, health)
	health -= damage_dealt
	damaged.emit(health, damage_dealt)

func take_knockback(knockback: float):
	print("took ", knockback, " knockback")
