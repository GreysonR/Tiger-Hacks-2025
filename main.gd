extends Node2D

@onready var health_btn : TextureButton = %UpgradeHealth
@onready var dmg_btn : TextureButton = %UpgradeDamage
@onready var rate_btn : TextureButton = %UpgradeFireRate
@onready var man_btn : TextureButton = %UpgradeManeuverability

# bloat
@onready var health_cost_t = %HealthCost
@onready var health_prog_t = %HealthProgress

@onready var damage_cost_t = %DamageCost
@onready var damage_prog_t = %DamageProgress

@onready var rate_cost_t = %RateCost
@onready var rate_prog_t = %RateProgress

@onready var man_cost_t = %ManCost
@onready var man_prog_t = %ManProgress

@onready var money_text = %MoneyText

func _ready():
	update_buttons()
	
func update_buttons():
	# Disabled if poor
	health_btn.disabled = PlayerStats.health_i >= PlayerStats.health_upgrade_costs.size() || PlayerStats.money < PlayerStats.health_upgrade_costs[PlayerStats.health_i]
	dmg_btn.disabled = PlayerStats.damage_i >= PlayerStats.damage_upgrade_costs.size() || PlayerStats.money < PlayerStats.damage_upgrade_costs[PlayerStats.damage_i]
	rate_btn.disabled = PlayerStats.fire_rate_i >= PlayerStats.fire_rate_upgrade_costs.size() || PlayerStats.money < PlayerStats.fire_rate_upgrade_costs[PlayerStats.fire_rate_i]
	man_btn.disabled = PlayerStats.man_i >= PlayerStats.man_upgrade_costs.size() || PlayerStats.money < PlayerStats.man_upgrade_costs[PlayerStats.man_i]
	
	# Update your poor ass's bank account
	money_text.text = str(PlayerStats.money)
	
	# Update all the text values
	health_cost_t.text = str(PlayerStats.health_upgrade_costs[PlayerStats.health_i])
	damage_cost_t.text = str(PlayerStats.damage_upgrade_costs[PlayerStats.damage_i])
	rate_cost_t.text = str(PlayerStats.fire_rate_upgrade_costs[PlayerStats.fire_rate_i])
	man_cost_t.text = str(PlayerStats.man_upgrade_costs[PlayerStats.man_i])
	
	health_prog_t.text = str(PlayerStats.health_i) + "/" + str(PlayerStats.health_upgrade_costs.size())
	damage_prog_t.text = str(PlayerStats.damage_i) + "/" + str(PlayerStats.damage_upgrade_costs.size())
	rate_prog_t.text = str(PlayerStats.fire_rate_i) + "/" + str(PlayerStats.fire_rate_upgrade_costs.size())
	man_prog_t.text = str(PlayerStats.man_i) + "/" + str(PlayerStats.man_upgrade_costs.size())


func _physics_process(_delta: float) -> void:
	if OS.is_debug_build() && Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _on_upgrade_health_pressed() -> void:
	PlayerStats.upgrade_health()
	update_buttons()


func _on_upgrade_damage_pressed() -> void:
	PlayerStats.upgrade_damage()
	update_buttons()

func _on_upgrade_fire_rate_button_down() -> void:
	PlayerStats.upgrade_fire_rate()
	update_buttons()


func _on_upgrade_maneuverability_pressed() -> void:
	PlayerStats.upgrade_man()
	update_buttons()

func _on_play_button_down() -> void:
	SceneSwitcher.switch_to("res://level1/level_1_wrap.tscn")
