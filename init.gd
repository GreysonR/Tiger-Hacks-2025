extends Node2D

func _ready():
	if (PlayerStats.load()): # Save game already exists; skip cutscene + go straight to upgrades
		SceneSwitcher.switch_to("res://main.tscn")
	else:
		SceneSwitcher.switch_to("res://cutscene/cutscene.tscn")
