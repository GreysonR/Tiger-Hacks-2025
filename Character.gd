extends Node2D
class_name Character

signal damaged(new_health: int, damage: int)
signal died(node)

@export var parent_body: CharacterBody2D
@export var max_health: int = 20
@export var cash_value : int = 0
@onready var health: int = max_health

var CashDropScene = load("res://cash_drop/cash_drop.tscn")

func take_damage(damage: int):
	if health <= 0 || damage <= 0:
		return
	
	var damage_dealt = min(damage, health)
	health -= damage_dealt
	damaged.emit(health, damage_dealt)
	
	if health <= 0:
		died.emit(self)
		drop_cash()

func take_knockback(knockback: Vector2):
	if knockback.length() == 0:
		return
	if !parent_body:
		return
	
	parent_body.velocity += knockback

func drop_cash():
	if cash_value == 0:
		return
	
	var cash_drop = CashDropScene.instantiate()
	cash_drop.cash_value = cash_value
	cash_drop.position = global_position
	get_tree().root.add_child(cash_drop)
