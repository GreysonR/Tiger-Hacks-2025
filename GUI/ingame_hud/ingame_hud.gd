extends Control

@onready var healthbar = %Healthbar
@onready var health_text = %HealthText
@onready var money_text = %MoneyText

@onready var wavebar = %Wavebar
@onready var wave_text = %WaveText

func _ready():
	var player = get_tree().get_first_node_in_group("PlayerCharacter")
	set_health(player.max_health, player.max_health)

func set_health(health: int, max_health):
	healthbar.max_value = max_health
	healthbar.value = health
	health_text.text = str(health) + "/" + str(max_health)
	
func set_wave(value: int, max_value):
	await get_tree().create_timer(0.2).timeout # janky fix to things not loading in time
	wavebar.max_value = max_value
	wavebar.value = value
	wave_text.text = "Wave " + str(value) + "/" + str(max_value)

func set_money(money: int):
	money_text.text = str(money)


func _on_player_damaged(new_health: int, _damage: int, max_health) -> void:
	set_health(new_health, max_health)


func _on_player_collected_coin() -> void:
	set_money(PlayerStats.money)
