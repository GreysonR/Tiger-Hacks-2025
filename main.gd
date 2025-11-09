extends Node2D

@onready var health_btn : TextureButton = %UpgradeHealth
@onready var dmg_btn : TextureButton = %UpgradeDamage
@onready var rate_btn : TextureButton = %UpgradeFireRate
@onready var man_btn : TextureButton = %UpgradeManeuverability

func _ready():
	if health_btn:
		health_btn.disabled = PlayerStats.money < PlayerStats.health_upgrade_costs[PlayerStats.health_i]
	if dmg_btn:
		dmg_btn.disabled = PlayerStats.money < PlayerStats.damage_upgrade_costs[PlayerStats.damage_i]
	if rate_btn:
		rate_btn.disabled = PlayerStats.money < PlayerStats.fire_rate_upgrade_costs[PlayerStats.fire_rate_i]
	if man_btn:
		man_btn.disabled = PlayerStats.money < PlayerStats.man_upgrade_costs[PlayerStats.man_i]

func _physics_process(_delta: float) -> void:
	if OS.is_debug_build() && Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _on_upgrade_health_pressed() -> void:
	PlayerStats.upgrade_health()


func _on_upgrade_damage_pressed() -> void:
	PlayerStats.upgrade_damage()

func _on_upgrade_fire_rate_button_down() -> void:
	PlayerStats.upgrade_fire_rate()


func _on_upgrade_maneuverability_pressed() -> void:
	PlayerStats.upgrade_man()

func _on_play_button_down() -> void:
	SceneSwitcher.switch_to("res://level1/level_1_wrap.tscn")
