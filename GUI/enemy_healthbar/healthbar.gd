extends Control

@onready var healthbar = %Healthbar

func set_health(health: int, max_health):
	healthbar.value = health
	healthbar.max_value = max_health
	
	healthbar.visible = health != max_health
