extends Node2D

var cash_value = 10
@export var speed_range = [10.0, 200.0]

var CoinScene = preload("res://cash_drop/coin/coin.tscn")

func _ready():
	SceneSwitcher.connect("unload", unload)
	for i in cash_value:
		spawn_coin()

func spawn_coin():
	var coin = CoinScene.instantiate()
	coin.position = global_position
	
	var dir = Vector2.from_angle(randf() * 2*PI)
	var speed = randf_range(speed_range[0], speed_range[1])
	coin.initial_velocity = dir * speed
	
	get_tree().root.call_deferred("add_child", coin)

func unload():
	queue_free()
